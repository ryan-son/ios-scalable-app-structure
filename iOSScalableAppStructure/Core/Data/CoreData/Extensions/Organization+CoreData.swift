//
//  Organization+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

import CoreData

extension Organization: CoreDataPersistable {

  typealias ManagedType = OrganizationEntity

  var keyMap: [PartialKeyPath<Organization>: String] {
    return [
      \.id: "id",
       \.contact: "contact",
       \.distance: "distance"
    ]
  }

  init(managedObject: OrganizationEntity?) {
    guard let managedObject = managedObject else { return }
    self.id = Int(managedObject.id)
    self.distance = managedObject.distance
    guard let contact = managedObject.contact else { return }
    self.contact = Contact(managedObject: contact)
  }

  func toManagedObject(context: NSManagedObjectContext) -> OrganizationEntity {
    let persistedValue = OrganizationEntity(context: context)
    persistedValue.distance = self.distance ?? 0

    if let contact = self.contact {
      persistedValue.contact = contact.toManagedObject(context: context)
    }
    return persistedValue
  }
}
