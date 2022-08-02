//
//  VideoLink+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

extension VideoLink: CoreDataPersistable {

  typealias ManagedType = VideoLinkEntity

  var keyMap: [PartialKeyPath<VideoLink> : String] {
    return [
      \.id: "id",
       \.embedded: "embedded"
    ]
  }
}
