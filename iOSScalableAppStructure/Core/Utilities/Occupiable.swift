//
//  Occupiable.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import struct SwiftUI.FetchedResults

protocol Occupiable {
  var isEmpty: Bool { get }
  var isNotEmpty: Bool { get }
}

extension Occupiable {
  var isNotEmpty: Bool {
    return !isEmpty
  }
}

extension AnyCollection: Occupiable {}
extension FetchedResults: Occupiable {}
extension Dictionary: Occupiable {}
extension Array: Occupiable {}
extension String: Occupiable {}
