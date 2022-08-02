//
//  Address+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

extension Address: CoreDataPersistable {

  typealias ManagedType = AddressEntity

  var keyMap: [PartialKeyPath<Address> : String] {
    return [
      \.address1: "address1",
       \.address2: "address2",
       \.city: "city",
       \.state: "state",
       \.postcode: "postcode",
       \.country: "country",
       \.id: "id"
    ]
  }
}
