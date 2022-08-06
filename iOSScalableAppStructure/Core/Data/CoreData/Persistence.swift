//
//  Persistence.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/31.
//

import CoreData

struct PersistenceController {

  static let shared = PersistenceController()

  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext

    for index in 0..<10 {
      var animal = Animal.mock[index]
      animal.toManagedObject(context: viewContext)
    }

    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()

  let container: NSPersistentCloudKitContainer

  init(inMemory: Bool = false) {
    container = NSPersistentCloudKitContainer(name: "iOSScalableAppStructure")

    if inMemory {
      container
        .persistentStoreDescriptions
        .first?
        .url = URL(fileURLWithPath: "/dev/null")
    }

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    container.viewContext.automaticallyMergesChangesFromParent = true
  }

  static func save() {
    let context = PersistenceController.shared.container.viewContext
    guard context.hasChanges else { return }

    do {
      try context.save()
    } catch {
      fatalError("""
        \(#file), \
        \(#function), \
        \(error.localizedDescription)
      """)
    }
  }
}
