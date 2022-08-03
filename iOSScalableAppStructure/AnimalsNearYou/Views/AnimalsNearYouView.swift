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
  @State var isLoading = true
  private let requestManager = RequestManager()

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
        await fetchAnimals()
      }
      .listStyle(.plain)
      .navigationTitle("Animals near you")
      .overlay {
        if isLoading {
          ProgressView("Finding Animals near you...")
        }
      }
    }
    .navigationViewStyle(.stack)
  }

  func fetchAnimals() async {
    do {
      let animalsContainer: AnimalsContainer = try await requestManager
        .perform(
          AnimalsRequest.getAnimalsWith(
            page: 1,
            latitude: nil,
            longitude: nil
          )
        )

      for var animal in animalsContainer.animals {
        animal.toManagedObject()
      }

      await stopLoading()
    } catch {
      print("Error fetching animals... \(error)")
    }
  }

  @MainActor
  func stopLoading() async {
    isLoading = false
  }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
  static var previews: some View {
    AnimalsNearYouView(isLoading: false)
      .environment(
        \.managedObjectContext,
         PersistenceController.preview.container.viewContext
      )
  }
}
