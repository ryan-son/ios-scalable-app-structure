//
//  Breed+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

import CoreData

extension Breed: CoreDataPersistable {

  typealias ManagedType = BreedEntity

  var keyMap: [PartialKeyPath<Breed> : String] {
    return [
      \.primary: "primary",
       \.secondary: "secondary",
       \.mixed: "mixed",
       \.unknown: "unknown",
       \.id: "id"
    ]
  }
}
