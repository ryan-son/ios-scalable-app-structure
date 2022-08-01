//
//  NetworkError.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

enum NetworkError: LocalizedError {
  case invalidServerResponse
  case invalidUrl

  var errorDescription: String? {
    switch self {
    case .invalidServerResponse:
      return "The server returned an invalid response."
    case .invalidUrl:
      return "URL string is malformed."
    }
  }
}
