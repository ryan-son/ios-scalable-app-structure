//
//  PhotoSizes.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

struct PhotoSizes: Decodable {
  var id: Int?
  var small: URL?
  var medium: URL?
  var large: URL?
  var full: URL?
}
