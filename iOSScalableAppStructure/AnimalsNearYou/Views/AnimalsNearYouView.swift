//
//  AnimalsNearYouView.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/31.
//

import SwiftUI

struct AnimalsNearYouView: View {

  @SectionedFetchRequest<String, AnimalEntity>(
    sectionIdentifier: \.animalSpecies,
    sortDescriptors: [
      NSSortDescriptor(keyPath: \AnimalEntity.species, ascending: true),
      NSSortDescriptor(keyPath: \AnimalEntity.timestamp, ascending: true)
    ],
    animation: .default
  )
  private var sectionedAnimals: SectionedFetchResults<String, AnimalEntity>
  @ObservedObject  var viewModel: AnimalsNearYouViewModel

  var body: some View {
    NavigationView {
      List {
        ForEach(sectionedAnimals) { section in
          Section(
            content: {
              ForEach(section) { animal in
                NavigationLink(destination: AnimalDetailsView.init) {
                  AnimalRow(animal: animal)
                }
              }
            },
            header: { Text(section.id) }
          )
        }
      }
      .task {
        await viewModel.fetchAnimals()
      }
      .listStyle(.plain)
      .navigationTitle("Animals near you")
      .overlay {
        if viewModel.isLoading && sectionedAnimals.isEmpty {
          ProgressView("Finding Animals near you...")
        }
      }
    }
    .navigationViewStyle(.stack)
  }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
  static var previews: some View {
    AnimalsNearYouView(
      viewModel: AnimalsNearYouViewModel(
        animalFetcher: AnimalsFetcherMock()
      )
    )
    .environment(
      \.managedObjectContext,
       PersistenceController.preview.container.viewContext
    )
  }
}
