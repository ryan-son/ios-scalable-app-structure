//
//  AnimalEnvironment+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

extension AnimalEnvironment: CoreDataPersistable {

  typealias ManagedType = AnimalEnvironmentEntity

  var keyMap: [PartialKeyPath<AnimalEnvironment>: String] {
    return [
      \.id: "id",
       \.cats: "cats",
       \.dogs: "dogs",
       \.children: "children"
    ]
  }
}
