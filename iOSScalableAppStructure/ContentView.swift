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
      AnimalsNearYouView()
        .environment(
          \.managedObjectContext,
           managedObjectContext
        )
        .tabItem {
          Label("Near you", systemImage: "location")
        }

      SearchView()
        .tabItem {
          Label("Search", systemImage: "magnifyingglass")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
