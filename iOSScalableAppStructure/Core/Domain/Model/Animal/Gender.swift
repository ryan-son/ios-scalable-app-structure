//
//  Gender.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

/// male, female, unknown Accepts multiple values, e.g. gender=male,female.
enum Gender: String, Decodable {
  case female = "Female"
  case male = "Male"
  case unknown = "Unknown"
}
