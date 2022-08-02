//
//  PhotoSizes+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

extension PhotoSizes: CoreDataPersistable {

  typealias ManagedType = PhotoSizesEntity

  var keyMap: [PartialKeyPath<PhotoSizes>: String] {
    return [
      \.id: "id",
       \.small: "small",
       \.medium: "medium",
       \.large: "large",
       \.full: "full",
    ]
  }
}
