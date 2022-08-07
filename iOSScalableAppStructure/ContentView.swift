//
//  ContentView.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/30.
//

import SwiftUI

struct ContentView: View {

  private let managedObjectContext = PersistenceController.shared.container.viewContext

  var body: some View {
    TabView {
      AnimalsNearYouView(
        viewModel: AnimalsNearYouViewModel(
          animalFetcher: FetchAnimalsService(
            requestManager: RequestManager()
          ),
          animalStore: AnimalStoreService(
            context: PersistenceController.shared.container.newBackgroundContext()
          )
        )
      )
      .tabItem {
        Label("Near you", systemImage: "location")
      }

      SearchView()
        .tabItem {
          Label("Search", systemImage: "magnifyingglass")
        }
    }
    .environment(\.managedObjectContext,managedObjectContext)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
