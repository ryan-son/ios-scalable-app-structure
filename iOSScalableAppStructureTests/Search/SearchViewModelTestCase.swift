//
//  SearchViewModelTestCase.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/07.
//

import XCTest
@testable import iOSScalableAppStructure

final class SearchViewModelTestCase: XCTestCase {

  let testContext = PersistenceController.preview.container.viewContext
  var sut: SearchViewModel!

  override func setUp() {
    super.setUp()
    sut = SearchViewModel(
      animalSearcher: AnimalSearcherMock(),
      animalStore: AnimalStoreService(context: testContext)
    )
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func testShouldFilterIsFalseForEmptyFilters() {
    XCTAssertTrue(sut.searchText.isEmpty)
    XCTAssertEqual(sut.ageSelection, .none)
    XCTAssertEqual(sut.typeSelection, .none)
    XCTAssertFalse(sut.shouldFilter)
  }

  func testShouldFilterIsTrueForSearchText() {
    sut.searchText = "Kiki"

    XCTAssertFalse(sut.searchText.isEmpty)
    XCTAssertEqual(sut.ageSelection, .none)
    XCTAssertEqual(sut.typeSelection, .none)
    XCTAssertTrue(sut.shouldFilter)
  }

  func testShouldFilterIsTrueForAgeFilter() {
    sut.ageSelection = .baby

    XCTAssertTrue(sut.searchText.isEmpty)
    XCTAssertEqual(sut.ageSelection, .baby)
    XCTAssertEqual(sut.typeSelection, .none)
    XCTAssertTrue(sut.shouldFilter)
  }

  func testShouldFilterIsTrueForTypeFilter() {
    sut.typeSelection = .cat

    XCTAssertTrue(sut.searchText.isEmpty)
    XCTAssertEqual(sut.ageSelection, .none)
    XCTAssertEqual(sut.typeSelection, .cat)
    XCTAssertTrue(sut.shouldFilter)
  }

  func testClearFiltersSearchTextIsNotEmpty() {
    sut.typeSelection = .cat
    sut.ageSelection = .baby
    sut.searchText = "Kiki"

    sut.clearFilters()

    XCTAssertFalse(sut.searchText.isEmpty)
    XCTAssertEqual(sut.ageSelection, .none)
    XCTAssertEqual(sut.typeSelection, .none)
    XCTAssertTrue(sut.shouldFilter)
  }

  func testClearFiltersSearchTextIsEmpty() {
    sut.typeSelection = .cat
    sut.ageSelection = .baby

    sut.clearFilters()

    XCTAssertTrue(sut.searchText.isEmpty)
    XCTAssertEqual(sut.ageSelection, .none)
    XCTAssertEqual(sut.typeSelection, .none)
    XCTAssertFalse(sut.shouldFilter)
  }

  func testSelectTypeSuggestion() {
    sut.selectTypeSuggestion(.cat)

    XCTAssertTrue(sut.searchText.isEmpty)
    XCTAssertEqual(sut.ageSelection, .none)
    XCTAssertEqual(sut.typeSelection, .cat)
    XCTAssertTrue(sut.shouldFilter)
  }
}
