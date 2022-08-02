//
//  ApiColors+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

extension ApiColors: CoreDataPersistable {

  typealias ManagedType = ApiColorsEntity

  var keyMap: [PartialKeyPath<ApiColors> : String] {
    return [
      \.id: "id",
       \.primary: "primary",
       \.secondary: "secondary",
       \.tertiary: "tertiary"
    ]
  }
}
