//
//  FilterAnimals.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/07.
//

import SwiftUI

struct FilterAnimals {

  let animals: FetchedResults<AnimalEntity>
  let query: String
  let age: AnimalSearchAge
  let type: AnimalSearchType

  func callAsFunction() -> [AnimalEntity] {
    let ageText = age.rawValue.lowercased()
    let typeText = type.rawValue.lowercased()
    return animals .filter {
      guard ageText != "none" else { return true }
      return $0.age.rawValue.lowercased() == ageText
    }
    .filter {
      guard typeText != "none" else { return true }
      return $0.type?.lowercased() == typeText
    }
    .filter {
      guard query.isNotEmpty else { return true }
      return $0.name?.contains(query) ?? false
    }
  }
}
