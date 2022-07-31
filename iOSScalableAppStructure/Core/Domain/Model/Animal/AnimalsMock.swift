//
//  AnimalsMock.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

private struct AnimalsMock: Decodable {
  let animals: [Animal]
}

private func loadAnimals() -> [Animal] {
  let url = Bundle.main.url(
    forResource: "AnimalsMock",
    withExtension: "json"
  )
  guard let url = url,
        let data = try? Data(contentsOf: url) else { return [] }

  let decoder = JSONDecoder()
  decoder.keyDecodingStrategy = .convertFromSnakeCase
  let jsonMock = try? decoder.decode(AnimalsMock.self, from: data)
  return jsonMock?.animals ?? []
}

extension Animal {
  static let mock = loadAnimals()
}
