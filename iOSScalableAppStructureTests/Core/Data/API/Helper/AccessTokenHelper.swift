//
//  AccessTokenHelper.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/01.
//

@testable import iOSScalableAppStructure

enum AccessTokenTestHelper {

  static func randomString() -> String {
    let letters = "abcdefghijklmnopqrstuvwxyz"
    return String(letters.shuffled().prefix(8))
  }

  static func randomApiToken() -> ApiToken {
    return ApiToken(
      tokenType: "Bearer",
      expiresIn: 10,
      accessToken: AccessTokenTestHelper.randomString()
    )
  }

  static func generateValidToken() -> String {
    return """
    {
      "token_type": "Bearer",
      "expires_in": 10,
      "access_token": \"\(randomString())\"
    }
    """
  }
}
