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

  private let animalFetcher: AnimalsFetcher
  private let animalStore: AnimalStore

  @Published var isLoading: Bool
  @Published var hasMoreAnimals = true
  private(set) var page = 1

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
      let animals = await animalFetcher.fetchAnimals(page: page)

      do {
        try await animalStore.save(animals: animals)
      } catch {
        print("Error storing animals... \(error.localizedDescription)")
      }

      self.isLoading = false
      self.hasMoreAnimals = animals.isNotEmpty
    }
  }

  func fetchMoreAnimals() async {
    page += 1
    await fetchAnimals()
  }
}
