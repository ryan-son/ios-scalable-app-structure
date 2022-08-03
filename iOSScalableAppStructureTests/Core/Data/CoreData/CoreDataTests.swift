//
//  CoreDataTests.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/02.
//

@testable import iOSScalableAppStructure
import XCTest

class CoreDataTests: XCTestCase {

  func testToManagedObject() throws {
    // Given
    let previewContext = PersistenceController.preview.container.viewContext

    // When
    let fetchRequest = AnimalEntity.fetchRequest()
    fetchRequest.fetchLimit = 1
    fetchRequest.sortDescriptors = [
      NSSortDescriptor(keyPath: \AnimalEntity.name, ascending: true)
    ]
    guard let results = try? previewContext.fetch(fetchRequest),
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
    // Given
    let previewContext = PersistenceController.preview.container.viewContext

    // When
    let fetchRequest = AnimalEntity.fetchRequest()
    guard let results = try? previewContext.fetch(fetchRequest),
          let first = results.first else { return }

    let expectedResult = results.count - 1
    previewContext.delete(first)

    // Then
    guard let resultsAfterDeletion = try? previewContext.fetch(fetchRequest).count else { return }
    XCTAssertEqual(
      expectedResult,
      resultsAfterDeletion,
      """
      The number of results was expected to be \(expectedResult) after deletion, was \(results.count)
      """
    )
  }
}
