//
//  Coat.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/31.
//

/// short, medium, long, wire, hairless, curly Accepts multiple values, e.g. coat=wire,curly.
enum Coat: String, Decodable {
  case short = "Short"
  case medium = "Medium"
  case long = "Long"
  case wire = "Wire"
  case hairless = "Hairless"
  case curly = "Curly"
  case unknown = "Unknown"
}
