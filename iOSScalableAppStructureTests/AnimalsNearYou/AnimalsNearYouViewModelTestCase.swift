//
//  AnimalsNearYouViewModelTestCase.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/06.
//

import XCTest
@testable import iOSScalableAppStructure

@MainActor
final class AnimalsNearYouViewModelTestCase: XCTestCase {

  let testContext = PersistenceController.preview.container.viewContext
  var viewModel: AnimalsNearYouViewModel!

  @MainActor
  override func setUp() {
    super.setUp()
    viewModel = AnimalsNearYouViewModel(
      isLoading: true,
      animalFetcher: AnimalsFetcherMock(),
      animalStore: AnimalStoreService(context: testContext)
    )
  }

  func testFetchAnimalsLoadingState() {
    Task { @MainActor in
      XCTAssertTrue(viewModel.isLoading, "The view model should be loading, but it isn't")
      await viewModel.fetchAnimals()
      XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading, but it is")
    }
  }
}
