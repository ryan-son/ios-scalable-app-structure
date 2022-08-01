//
//  ApiManager.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

protocol ApiManagerProtocol {
  func perform(
    _ request: RequestProtocol,
    authToken: String
  ) async throws -> Data
}

final class ApiManager: ApiManagerProtocol {

  private let urlSession: URLSession

  init(
    urlSession: URLSession = URLSession.shared
  ) {
    self.urlSession = urlSession
  }

  func perform(
    _ request: RequestProtocol,
    authToken: String = ""
  ) async throws -> Data {
    let (data, response) = try await urlSession.data(
      for: request.createUrlRequest(authToken: authToken)
    )

    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      throw NetworkError.invalidServerResponse
    }
    return data
  }
}
