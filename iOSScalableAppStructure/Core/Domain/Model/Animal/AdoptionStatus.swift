//
//  AdoptionStatus.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

/// adoptable, adopted, found Accepts multiple values (default: adoptable)
enum AdoptionStatus: String, Decodable {
  case adoptable
  case adopted
  case found
  case unknown
}
