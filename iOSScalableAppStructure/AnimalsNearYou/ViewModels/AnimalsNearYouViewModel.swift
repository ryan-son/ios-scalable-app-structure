//
//  AnimalsNearYouViewModel.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/05.
//

import Foundation

protocol AnimalsFetcher {
  func fetchAnimals(page: Int) async -> [Animal]
}

protocol AnimalStore {
  func save(animals: [Animal]) async throws
}

@MainActor
final class AnimalsNearYouViewModel: ObservableObject {

  @Published var isLoading: Bool
  private let animalFetcher: AnimalsFetcher
  private let animalStore: AnimalStore

  init(
    isLoading: Bool = true,
    animalFetcher: AnimalsFetcher,
    animalStore: AnimalStore
  ) {
    self.isLoading = isLoading
    self.animalFetcher = animalFetcher
    self.animalStore = animalStore
  }

  func fetchAnimals() async {
    Task { @MainActor in
      let animals = await animalFetcher.fetchAnimals(page: 1)

      do {
        try await animalStore.save(animals: animals)
      } catch {
        print("Error storing animals... \(error.localizedDescription)")
      }

      self.isLoading = false
    }
  }
}
