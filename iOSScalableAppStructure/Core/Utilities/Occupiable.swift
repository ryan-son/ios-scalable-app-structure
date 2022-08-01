//
//  Occupiable.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

protocol Occupiable {
  var isEmpty: Bool { get }
  var isNotEmpty: Bool { get }
}

extension Occupiable {
  var isNotEmpty: Bool {
    return !isEmpty
  }
}

extension Dictionary: Occupiable {}
extension String: Occupiable {}
