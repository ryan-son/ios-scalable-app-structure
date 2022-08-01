//
//  AnimalsNearYouView.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/31.
//

import SwiftUI

struct AnimalsNearYouView: View {

  @State var animals: [Animal] = []
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

      let animals = animalsContainer.animals
      self.animals = animals
      await stopLoading()
    } catch {
      print(error)
    }
  }

  @MainActor
  func stopLoading() async {
    isLoading = false
  }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
  static var previews: some View {
    AnimalsNearYouView(animals: Animal.mock, isLoading: false)
  }
}
