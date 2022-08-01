//
//  DataParser.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

protocol DataParserProtocol {
  func parse<T: Decodable>(data: Data) throws -> T
}

final class DataParser: DataParserProtocol {
  private var jsonDecoder: JSONDecoder

  init(
    jsonDecoder: JSONDecoder = JSONDecoder()
  ) {
    self.jsonDecoder = jsonDecoder
    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
  }

  func parse<T: Decodable>(data: Data) throws -> T {
    return try jsonDecoder.decode(T.self, from: data)
  }
}
