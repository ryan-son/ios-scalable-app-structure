//
//  AnimalsNearYouViewModelTestCase.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/06.
//

import XCTest
@testable import iOSScalableAppStructure

final class AnimalsNearYouViewModelTestCase: XCTestCase {

  let testContext = PersistenceController.preview.container.viewContext
  var sut: AnimalsNearYouViewModel!

  override func setUp() {
    Task { @MainActor in
      try await super.setUp()
      sut = AnimalsNearYouViewModel(
        isLoading: true,
        animalFetcher: AnimalsFetcherMock(),
        animalStore: AnimalStoreService(context: testContext)
      )
    }
  }

  override func tearDown() {
    Task { @MainActor in
      sut = nil
      try await super.tearDown()
    }
  }

  func testFetchAnimalsLoadingState() {
    Task { @MainActor in
      XCTAssertTrue(sut.isLoading, "The view model should be loading, but it isn't")
      await sut.fetchAnimals()
      XCTAssertFalse(sut.isLoading, "The view model shouldn't be loading, but it is")
    }
  }

  func testUpdatePageOnFetchMoreAnimals() {
    Task { @MainActor in
      XCTAssertEqual(
        sut.page,
        1,
        "the view model's page property should be 1 before fetching, but it's \(sut.page)"
      )
      await sut.fetchAnimals()
      XCTAssertEqual(
        sut.page,
        2,
        "the view model's page property should be 2 after fetching, but it's \(sut.page)"
      )
    }
  }

  func testFetchAnimalsEmptyResponse() {
    Task { @MainActor in
      sut = AnimalsNearYouViewModel(
        isLoading: true,
        animalFetcher: EmptyResponseAnimalsFetcherMock(),
        animalStore: AnimalStoreService(context: testContext)
      )

      await sut.fetchAnimals()

      XCTAssertFalse(
        sut.hasMoreAnimals,
        "hasMoreAnimals should be false with an empty response, but it's true"
      )
      XCTAssertFalse(
        sut.isLoading,
        "the view model shouldn't be loading after receiving an empty response, but it is"
      )
    }
  }
}

struct EmptyResponseAnimalsFetcherMock: AnimalsFetcher {

  func fetchAnimals(page: Int) async -> [Animal] {
    return []
  }
}
