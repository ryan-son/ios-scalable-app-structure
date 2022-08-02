//
//  Contact+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

import CoreData

extension Contact: CoreDataPersistable {

  typealias ManagedType = ContactEntity

  var keyMap: [PartialKeyPath<Contact>: String] {
    return [
      \.id: "id",
       \.address: "address",
       \.phone: "phone",
       \.email: "email"
    ]
  }

  init(managedObject: ContactEntity?) {
    guard let managedObject = managedObject else { return }
    self.id = Int(managedObject.id)
    self.email = managedObject.email
    self.phone = managedObject.phone
    self.address = Address(managedObject: managedObject.address)
  }

  func toManagedObject(context: NSManagedObjectContext) -> ContactEntity {
    let persistedValue = ContactEntity(context: context)
    persistedValue.email = self.email
    persistedValue.phone = self.phone

    if var address = self.address {
      persistedValue.address = address.toManagedObject(context: context)
    }
    return persistedValue
  }
}
