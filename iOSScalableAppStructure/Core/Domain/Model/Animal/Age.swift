//
//  Age.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import struct SwiftUI.Color

/// baby, young, adult, senior Accepts multiple values, e.g. age=baby,senior.
enum Age: String, Decodable {
  case baby = "Baby"
  case young = "Young"
  case adult = "Adult"
  case senior = "Senior"
  case unknown = "Unknown"
}

// MARK: - Agewise color

extension Age {

  var color: Color {
    switch self {
    case .baby:
      return .cyan
    case .young:
      return .orange
    case .adult:
      return .green
    case .senior:
      return .blue
    case .unknown:
      return .clear
    }
  }
}
