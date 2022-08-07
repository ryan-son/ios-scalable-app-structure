//
//  SearchView.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/31.
//

import SwiftUI

struct SearchView: View {

  @FetchRequest(
    sortDescriptors: [
      NSSortDescriptor(
        keyPath: \AnimalEntity.timestamp,
        ascending: true
      )
    ],
    animation: .default
  )
  private var animals: FetchedResults<AnimalEntity>
  @State var searchText = ""
  var filteredAnimals: [AnimalEntity] {
    return animals.filter {
      guard searchText.isNotEmpty else { return true }
      return $0.name?.contains(searchText) ?? false
    }
  }

  var body: some View {
    NavigationView {
      AnimalListView(animals: filteredAnimals)
        .searchable(
          text: $searchText,
          placement: .navigationBarDrawer(displayMode: .always)
        )
        .navigationTitle("Find your future pet")
    }
    .navigationViewStyle(.stack)
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}
