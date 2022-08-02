//
//  AnimalsNearYouView.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/31.
//

import SwiftUI

struct AnimalsNearYouView: View {

  @State var animals: [AnimalEntity] = []
  @State var isLoading = true
  private let requestManager = RequestManager()

  var body: some View {
    NavigationView {
      List {
        ForEach(animals) { animal in
          AnimalRowView(animal: animal)
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
    if let animals = CoreDataHelper.testAnimalEntities() {
      AnimalsNearYouView(animals: animals, isLoading: false)
    }
  }
}
