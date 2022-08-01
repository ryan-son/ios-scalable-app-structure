//
//  AccessTokenManager.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

protocol AccessTokenManagerProtocol {
  func isTokenValid() -> Bool
  func fetchToken() -> String
  func refreshWith(apiToken: ApiToken) throws
}

final class AccessTokenManager {
  private let userDefaults: UserDefaults
  private var accessToken: String?
  private var expiresAt = Date()

  init(
    userDefaults: UserDefaults = .standard
  ) {
    self.userDefaults = userDefaults
    update()
  }
}

// MARK: - Access Token Manager Protocol

extension AccessTokenManager: AccessTokenManagerProtocol {

  func isTokenValid() -> Bool {
    update()
    return accessToken != nil && expiresAt.compare(Date()) == .orderedDescending
  }

  func fetchToken() -> String {
    return accessToken ?? ""
  }

  func refreshWith(apiToken: ApiToken) throws {
    let expiresAt = apiToken.expiresAt
    let token = apiToken.bearerAccessToken

    save(token: apiToken)
    self.expiresAt = expiresAt
    self.accessToken = token
  }
}

// MARK: - Token Expiration

private extension AccessTokenManager {
  func save(token: ApiToken) {
    userDefaults.set(token.expiresAt.timeIntervalSince1970, forKey: AppUserDefaultsKeys.expiresAt)
    userDefaults.set(token.bearerAccessToken, forKey: AppUserDefaultsKeys.bearerAccessToken)
  }

  func expirationDate() -> Date {
    return Date(timeIntervalSince1970: userDefaults.double(forKey: AppUserDefaultsKeys.expiresAt))
  }

  func token() -> String? {
    return userDefaults.string(forKey: AppUserDefaultsKeys.bearerAccessToken)
  }

  func update() {
    accessToken = token()
    expiresAt = expirationDate()
  }
}
