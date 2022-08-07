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
  @State var filterPickerIsPresented: Bool = false

  @StateObject var viewModel = SearchViewModel(
    animalSearcher: AnimalSearcherService(requestManager: RequestManager()),
    animalStore: AnimalStoreService(
      context: PersistenceController.shared.container.newBackgroundContext()
    )
  )
  var filteredAnimals: [AnimalEntity] {
    guard viewModel.shouldFilter else { return [] }
    return filterAnimals()
  }
  private var filterAnimals: FilterAnimals {
    return FilterAnimals(
      animals: animals,
      query: viewModel.searchText,
      age: viewModel.ageSelection,
      type: viewModel.typeSelection
    )
  }

  var body: some View {
    NavigationView {
      AnimalListView(animals: filteredAnimals)
        .overlay {
          if filteredAnimals.isEmpty && viewModel.searchText.isNotEmpty {
            EmptyResultsView(query: viewModel.searchText)
          }
        }
        .toolbar {
          ToolbarItem {
            Button(action: { filterPickerIsPresented.toggle() }) {
              Label("Filter", systemImage: "slider.horizontal.3")
            }
            .sheet(isPresented: $filterPickerIsPresented) {
              NavigationView {
                SearchFilterView(viewModel: viewModel)
              }
            }
          }
        }
        .overlay {
          if filteredAnimals.isEmpty && viewModel.searchText.isEmpty {
            SuggestionGrid(suggestions: AnimalSearchType.suggestions) { suggestion in
              viewModel.selectTypeSuggestion(suggestion)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
          }
        }
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
