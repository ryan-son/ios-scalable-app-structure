//
//  AnimalAttributes+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

extension AnimalAttributes: CoreDataPersistable {

  typealias ManagedType = AnimalAttributesEntity

  var keyMap: [PartialKeyPath<AnimalAttributes>: String] {
    return [
      \.id: "id",
       \.declawed: "declawed",
       \.houseTrained: "houseTrained",
       \.shotsCurrent: "shotsCurrent",
       \.spayedNeutered: "spayedNeutered",
       \.specialNeeds: "specialNeeds"
    ]
  }
}
