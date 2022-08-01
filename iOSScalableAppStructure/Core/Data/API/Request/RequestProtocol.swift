//
//  RequestProtocol.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

protocol RequestProtocol {
  var path: String { get }
  var headers: [String: String] { get }
  var params: [String: Any] { get }
  var urlParams: [String: String?] { get }
  var addAuthorizationToken: Bool { get }
  var requestType: RequestType { get }
}

extension RequestProtocol {
  var host: String {
    return ApiConstants.host
  }

  var addAuthorizationToken: Bool {
    return true
  }

  var params: [String: Any] {
    return [:]
  }

  var urlParams: [String: String?] {
    return [:]
  }

  var headers: [String: String] {
    return [:]
  }

  func createUrlRequest(authToken: String) throws -> URLRequest {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path

    if urlParams.isNotEmpty {
      components.queryItems = urlParams.map(URLQueryItem.init(name:value:))
    }

    guard let url = components.url else {
      throw NetworkError.invalidUrl
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = requestType.rawValue

    if headers.isNotEmpty {
      urlRequest.allHTTPHeaderFields = headers
    }

    if addAuthorizationToken {
      urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
    }

    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    if params.isNotEmpty {
      urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
    }

    return urlRequest
  }
}
