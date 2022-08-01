//
//  RequestManager.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

protocol RequestManagerProtocol {
  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

final class RequestManager: RequestManagerProtocol {

  let apiManager: ApiManagerProtocol
  let parser: DataParserProtocol

  init(
    apiManager: ApiManagerProtocol = ApiManager(),
    parser: DataParserProtocol = DataParser()
  ) {
    self.apiManager = apiManager
    self.parser = parser
  }

  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
    let authToken = try await requestAccessToken()
    let data = try await apiManager.perform(request, authToken: authToken)
    let decoded: T = try parser.parse(data: data)
    return decoded
  }

  func requestAccessToken() async throws -> String {
    let data = try await apiManager.requestToken()
    let token: ApiToken = try parser.parse(data: data)
    return token.bearerAccessToken
  }
}
