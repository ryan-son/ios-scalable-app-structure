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


  @StateObject var viewModel = SearchViewModel(
    animalSearcher: AnimalSearcherService(requestManager: RequestManager()),
    animalStore: AnimalStoreService(
      context: PersistenceController.shared.container.newBackgroundContext()
    )
  )
  var filteredAnimals: [AnimalEntity] {
    guard viewModel.shouldFilter else { return [] }
    return animals.filter {
      guard viewModel.searchText.isNotEmpty else { return true }
      return $0.name?.contains(viewModel.searchText) ?? false
    }
  }

  var body: some View {
    NavigationView {
      AnimalListView(animals: filteredAnimals)
        .searchable(
          text: $viewModel.searchText,
          placement: .navigationBarDrawer(displayMode: .always)
        )
        .onChange(of: viewModel.searchText) { _ in
          viewModel.search()
        }
        .navigationTitle("Find your future pet")
    }
    .navigationViewStyle(.stack)
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView(
      viewModel: SearchViewModel(
        animalSearcher: AnimalSearcherMock(),
        animalStore: AnimalStoreService(
          context: PersistenceController.preview.container.viewContext
        )
      )
    )
    .environment(
      \.managedObjectContext,
       PersistenceController.preview.container.viewContext
    )
  }
}
