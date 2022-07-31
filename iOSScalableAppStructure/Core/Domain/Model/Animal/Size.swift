//
//  Size.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

/// small, medium, large, xlarge Accepts multiple values, e.g. size=large,xlarge.
enum Size: String, Decodable {
  case small = "Small"
  case medium = "Medium"
  case large = "Large"
  case extraLarge = "Extra Large"
  case unknown = "Unknown"
}
