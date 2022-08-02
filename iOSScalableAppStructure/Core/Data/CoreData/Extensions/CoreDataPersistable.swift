//
//  CoreDataPersistable.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

import CoreData

protocol UuidIdentifiable: Identifiable {
  var id: Int? { get set }
}

protocol CoreDataPersistable: UuidIdentifiable {

  associatedtype ManagedType

  init()
  init(managedObject: ManagedType?)

  var keyMap: [PartialKeyPath<Self>: String] { get }

  mutating func toManagedObject(context: NSManagedObjectContext) -> ManagedType
  func save(context: NSManagedObjectContext) throws
}

extension CoreDataPersistable where ManagedType: NSManagedObject {

  init(managedObject: ManagedType?) {
    self.init()
    guard let managedObject = managedObject else { return }

    for attribute in managedObject.entity.attributesByName {
      let keyPath = keyMap
        .first(where: { $0.value == attribute.key })?
        .key
      if let keyPath = keyPath {
        let value = managedObject.value(forKey: attribute.key)
        storeValue(value, toKeyPath: keyPath)
      }
    }
  }

  private mutating func storeValue(
    _ value: Any?,
    toKeyPath partial: AnyKeyPath
  ) {
    switch partial {
    case let keyPath as WritableKeyPath<Self, URL?>:
      self[keyPath: keyPath] = value as? URL
    case let keyPath as WritableKeyPath<Self, Int?>:
      self[keyPath: keyPath] = value as? Int
    case let keyPath as WritableKeyPath<Self, String?>:
      self[keyPath: keyPath] = value as? String
    case let keyPath as WritableKeyPath<Self, Bool?>:
      self[keyPath: keyPath] = value as? Bool
    case let keyPath as WritableKeyPath<Self, Double?>:
      self[keyPath: keyPath] = value as? Double
    default:
      return
    }
  }

  mutating func toManagedObject(
    context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
  ) -> ManagedType {
    let persistedValue: ManagedType

    if let id = self.id {
      let fetchRequest = ManagedType.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)

      if let results = try? context.fetch(fetchRequest),
         let firstResult = results.first as? ManagedType {
        persistedValue = firstResult
      } else {
        persistedValue = ManagedType(context: context)
        self.id = persistedValue.value(forKey: "id") as? Int
      }
    } else {
      persistedValue = ManagedType(context: context)
      self.id = persistedValue.value(forKey: "id") as? Int
    }
    return setValuesFromMirror(persistedValue: persistedValue)
  }

  private func setValuesFromMirror(persistedValue: ManagedType) -> ManagedType {
    let mirror = Mirror(reflecting: self)

    for case let (label?, value) in mirror.children {
      let mirroredValue = Mirror(reflecting: value)

      if mirroredValue.displayStyle != .optional ||
          mirroredValue.children.isNotEmpty {
        persistedValue.setValue(value, forKey: label)
      }
    }
    return persistedValue
  }

  func save(
    context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
  ) throws {
    try context.save()
  }
}