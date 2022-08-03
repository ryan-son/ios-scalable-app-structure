//
//  CoreDataTests.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/02.
//

@testable import iOSScalableAppStructure
import XCTest

class CoreDataTests: XCTestCase {

  private let sut = PersistenceController.preview.container.viewContext

  override func tearDownWithError() throws {
    sut.rollback()
    try super.tearDownWithError()
  }

  func testToManagedObject() throws {
    // When
    let fetchRequest = AnimalEntity.fetchRequest()
    fetchRequest.fetchLimit = 1
    fetchRequest.sortDescriptors = [
      NSSortDescriptor(keyPath: \AnimalEntity.name, ascending: true)
    ]
    guard let results = try? sut.fetch(fetchRequest),
          let first = results.first else {
      XCTFail("Failed to fetch an animal entity")
      return
    }

    // Then
    XCTAssert(
      first.name == "CHARLA",
      "Pet name did not match, was expecting Kiki, got \(String(describing: first.name))"
    )
    XCTAssert(
      first.type == "Dog",
      "Pet type did not match, was expecting Cat, got \(String(describing: first.type))"
    )
    XCTAssert(
      first.coat.rawValue == "Short",
      "Pet coat did not match, was expecting Short, got \(first.coat.rawValue)"
    )
  }

  func testDeleteManagedObject() throws {
    // When
    let fetchRequest = AnimalEntity.fetchRequest()
    guard let results = try? sut.fetch(fetchRequest),
          let first = results.first else {
      XCTFail("No results")
      return
    }

    let expectedResult = results.count - 1
    sut.delete(first)

    // Then
    guard let resultsAfterDeletion = try? sut.fetch(fetchRequest).count else {
      XCTFail("No results")
      return
    }
    XCTAssertEqual(
      expectedResult,
      resultsAfterDeletion,
      """
      The number of results was expected to be \(expectedResult) after deletion, was \(results.count)
      """
    )
  }

  func testFetchManagedObject() throws {
    // When
    let expectedResultsCount = 1
    let expectedResultName = "Ellie"
    let fetchRequest = AnimalEntity.fetchRequest()
    fetchRequest.fetchLimit = expectedResultsCount
    fetchRequest.predicate = NSPredicate(format: "name == %@", expectedResultName)
    guard let results = try? sut.fetch(fetchRequest),
          let first = results.first else {
      XCTFail("No results")
      return
    }

    XCTAssertEqual(
      results.count,
      expectedResultsCount,
      """
      The number of results was expected to be \(expectedResultsCount), was \(results.count)
      """
    )
    XCTAssertEqual(
      first.name,
      expectedResultName,
      """
      Pet name did not match, expecting \(expectedResultName), got \(String(describing: first.name))
      """
    )
  }
}
