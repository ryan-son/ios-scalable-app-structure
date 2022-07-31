//
//  Age.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

/// baby, young, adult, senior Accepts multiple values, e.g. age=baby,senior.
enum Age: String, Decodable {
  case baby = "Baby"
  case young = "Young"
  case adult = "Adult"
  case senior = "Senior"
  case unknown = "Unknown"
}
