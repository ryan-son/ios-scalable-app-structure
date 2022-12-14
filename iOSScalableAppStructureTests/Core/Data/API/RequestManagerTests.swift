//
//  RequestManagerTests.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/01.
//

import XCTest
@testable import iOSScalableAppStructure

class RequestManagerTests: XCTestCase {

  private var sut: RequestManagerProtocol?

  override func setUp() {
    super.setUp()
    guard let userDefaults = UserDefaults(suiteName: #file) else { return }
    userDefaults.removePersistentDomain(forName: #file)
    sut = RequestManager(
      apiManager: ApiManagerMock(),
      accessTokenManager: AccessTokenManager(userDefaults: userDefaults)
    )
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func testRequestAnimals() async throws {
    guard let container: AnimalsContainer = try await sut?
      .perform(AnimalsRequestMock.getAnimals) else {
        XCTFail("Didn't get data form the request manager")
        return
    }

    let animals = container.animals
    let (first, last) = (animals.first, animals.last)

    XCTAssertEqual(first?.name, "Kiki")
    XCTAssertEqual(first?.age.rawValue, "Adult")
    XCTAssertEqual(first?.gender.rawValue, "Female")
    XCTAssertEqual(first?.size.rawValue, "Medium")
    XCTAssertEqual(first?.coat?.rawValue, "Short")

    XCTAssertEqual(last?.name, "Midnight")
    XCTAssertEqual(last?.age.rawValue, "Adult")
    XCTAssertEqual(last?.gender.rawValue, "Female")
    XCTAssertEqual(last?.size.rawValue, "Large")
    XCTAssertEqual(last?.coat, nil)
  }
}
