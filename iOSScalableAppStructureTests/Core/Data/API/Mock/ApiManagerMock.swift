//
//  ApiManagerMock.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation
@testable import iOSScalableAppStructure

struct ApiManagerMock: ApiManagerProtocol {

  func perform(
    _ request: RequestProtocol,
    authToken: String
  ) async throws -> Data {
    return try Data(
      contentsOf: URL(fileURLWithPath: request.path),
      options: .mappedIfSafe
    )
  }

  func requestToken() async throws -> Data {
    return Data(AccessTokenTestHelper.generateValidToken().utf8)
  }
}
