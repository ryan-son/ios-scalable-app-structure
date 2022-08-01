//
//  ApiToken.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

struct ApiToken {
  let tokenType: String
  let expiresIn: Int
  let accessToken: String
  private let requestedAt = Date()
}


// MARK: - Codable

extension ApiToken: Codable {
  enum CodingKeys: String, CodingKey {
    case tokenType
    case expiresIn
    case accessToken
  }
}

// MARK: - Helper properties

extension ApiToken {
  var expiresAt: Date {
    return Calendar.current.date(
      byAdding: .second,
      value: expiresIn,
      to: requestedAt
    ) ?? Date()
  }

  var bearerAccessToken: String {
    return "\(tokenType) \(accessToken))"
  }
}
