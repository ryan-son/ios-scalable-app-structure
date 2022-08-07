//
//  SuggestionGrid.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/07.
//

import SwiftUI

struct SuggestionGrid: View {

  @Environment(\.isSearching) var isSearching: Bool

  let suggestions: [AnimalSearchType]
  var action: (AnimalSearchType) -> Void

  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  var body: some View {
    VStack(alignment: .leading) {
      Text("Browse by Type")
        .font(.title2.bold())

      LazyVGrid(columns: columns) {
        ForEach(AnimalSearchType.suggestions, id: \.self) { suggestion in
          Button(action: { action(suggestion) }) {
            AnimalTypeSuggestionView(suggestion: suggestion)
          }
          .buttonStyle(.plain)
        }
      }
    }
    .padding(.horizontal)
    .opacity(isSearching ? 0 : 1)
  }
}

struct SuggestionGrid_Previews: PreviewProvider {
  static var previews: some View {
    SuggestionGrid(
      suggestions: AnimalSearchType.suggestions,
      action: { _ in }
    )
  }
}
