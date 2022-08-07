//
//  AnimalSearchType.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/07.
//

import SwiftUI

enum AnimalSearchType: String, CaseIterable {
  case none
  case cat
  case dog
  case rabbit
  case smallAndFurry = "small & furry"
  case horse
  case bird
  case scalesFinsAndOther = "scales, fins & other"
  case barnyard
}

// MARK: - Return appropriate animal images

extension AnimalSearchType {

  var suggestionImage: Image {
    switch self {
    case .smallAndFurry:
      return Image("smallAndFurry")
    case .scalesFinsAndOther:
      return Image("scalesFinsAndOther")
    default:
      return Image(rawValue)
    }
  }
}

// MARK: - Return suggestions

extension AnimalSearchType {

  static var suggestions: [AnimalSearchType] {
    var suggestions = AnimalSearchType.allCases
    suggestions.removeFirst() // Removing 'none' from suggestions
    return suggestions
  }
}
