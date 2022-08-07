//
//  SearchViewModel.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/07.
//

import Foundation

protocol AnimalSearcher {
  func searchAnimal(
    by text: String,
    age: AnimalSearchAge,
    type: AnimalSearchType
  ) async -> [Animal]
}

final class SearchViewModel: ObservableObject {

  @Published var searchText = ""

  var shouldFilter: Bool {
    return searchText.isNotEmpty
  }

  private let animalSearcher: AnimalSearcher
  private let animalStore: AnimalStore

  init(
    animalSearcher: AnimalSearcher,
    animalStore: AnimalStore
  ) {
    self.animalSearcher = animalSearcher
    self.animalStore = animalStore
  }

  func search() {
    Task {
      let animals = await animalSearcher.searchAnimal(
        by: searchText,
        age: .none,
        type: .none
      )

      do {
        try await animalStore.save(animals: animals)
      } catch {
        print("Error storing animals... \(error.localizedDescription)")
      }
    }
  }
}
