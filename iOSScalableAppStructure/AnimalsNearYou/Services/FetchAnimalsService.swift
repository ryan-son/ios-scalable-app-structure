//
//  FetchAnimalsService.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/06.
//

import Foundation

struct FetchAnimalsService {

  private let requestManager: RequestManagerProtocol

  init(
    requestManager: RequestManagerProtocol
  ) {
    self.requestManager = requestManager
  }
}

// MARK: - AnimalFetcher

extension FetchAnimalsService: AnimalsFetcher {

  func fetchAnimals(page: Int) async -> [Animal] {
    let requestData = AnimalsRequest.getAnimalsWith(
      page: page,
      latitude: nil,
      longitude: nil
    )

    do {
      let animalsContainer: AnimalsContainer = try await requestManager.perform(requestData)
      return animalsContainer.animals
    } catch {
      print(error.localizedDescription)
      return []
    }
  }
}
