//
//  AnimalsRequestMock.swift
//  iOSScalableAppStructureTests
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation
@testable import iOSScalableAppStructure

enum AnimalsRequestMock: RequestProtocol {
  case getAnimals

  var requestType: RequestType {
    return .get
  }

  var path: String {
    return Bundle.main.path(
      forResource: "AnimalsMock",
      ofType: "json"
    ) ?? ""
  }
}
