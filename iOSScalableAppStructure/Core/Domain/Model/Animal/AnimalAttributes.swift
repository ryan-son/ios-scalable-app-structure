//
//  AnimalAttributes.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

struct AnimalAttributes: Decodable {
  var id: Int?
  var spayedNeutered: Bool? = false
  var houseTrained: Bool? = false
  var declawed: Bool? = false
  var specialNeeds: Bool? = false
  var shotsCurrent: Bool? = false
}
