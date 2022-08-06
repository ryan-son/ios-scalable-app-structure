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

@MainActor
final class AnimalsNearYouViewModel: ObservableObject {
  @Published var isLoading: Bool
  private let animalFetcher: AnimalsFetcher

  init(
    isLoading: Bool = true,
    animalFetcher: AnimalsFetcher
  ) {
    self.isLoading = isLoading
    self.animalFetcher = animalFetcher
  }

  func fetchAnimals() async {
    Task { @MainActor in
      let animals = await animalFetcher.fetchAnimals(page: 1)

      for var animal in animals {
        animal.toManagedObject()
      }

      self.isLoading = false
    }
  }
}
