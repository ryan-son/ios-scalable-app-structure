//
//  AccessTokenManagerTests.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/01.
//

import XCTest
@testable import iOSScalableAppStructure

class AccessTokenManagerTests: XCTestCase {

  private var sut: AccessTokenManagerProtocol?
  private let token = AccessTokenTestHelper.randomApiToken()

  override func setUp() {
    super.setUp()
    guard let userDefaults = UserDefaults(suiteName: #file) else { return }

    userDefaults.removePersistentDomain(forName: #file)
    userDefaults.set(token.expiresAt.timeIntervalSince1970, forKey: AppUserDefaultsKeys.expiresAt)
    userDefaults.set(token.bearerAccessToken, forKey: AppUserDefaultsKeys.bearerAccessToken)

    sut = AccessTokenManager(userDefaults: userDefaults)
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func testRequestToken() throws {
    // Given: set token at setUp()

    // When:
    let fetchedToken = sut?.fetchToken()

    // Then
    XCTAssertEqual(fetchedToken?.isNotEmpty, true)
  }

  func testCachedToken() {
    // Given: set randomApiToken at setUp()

    // When
    let fetchedToken = sut?.fetchToken()

    // Then
    XCTAssertEqual(token.bearerAccessToken, fetchedToken)
  }

  func testRefreshToken() throws {
    // Given
    let randomToken = AccessTokenTestHelper.randomApiToken()

    // When
    try sut?.refreshWith(apiToken: randomToken)

    // Then
    XCTAssertNotEqual(token.bearerAccessToken, sut?.fetchToken())
    XCTAssertEqual(randomToken.bearerAccessToken, sut?.fetchToken())
  }
}
