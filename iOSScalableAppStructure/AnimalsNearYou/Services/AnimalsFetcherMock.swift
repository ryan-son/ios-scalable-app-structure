//
//  AnimalsFetcherMock.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/06.
//

struct AnimalsFetcherMock: AnimalsFetcher {

  func fetchAnimals(page: Int) async -> [Animal] {
    return Animal.mock
  }
}
