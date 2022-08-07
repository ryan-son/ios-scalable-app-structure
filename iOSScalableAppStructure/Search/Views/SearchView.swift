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

  var body: some View {
    NavigationView {
      AnimalListView(animals: animals)
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
