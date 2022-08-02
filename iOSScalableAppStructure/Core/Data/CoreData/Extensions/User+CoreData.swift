//
//  User+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

extension User: CoreDataPersistable {

  typealias ManagedType = UserEntity

  var keyMap: [PartialKeyPath<User> : String] {
    return [
      \.id: "id",
       \.name: "name",
       \.password: "password",
       \.extra: "extra"
    ]
  }
}
