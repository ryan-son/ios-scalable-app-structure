//
//  AnimalTypeSuggestionView.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/07.
//

import SwiftUI

struct AnimalTypeSuggestionView: View {

  let suggestion: AnimalSearchType
  private var gradientColors: [Color] {
    return [.clear, .black]
  }

  @ViewBuilder private var gradientOverlay: some View {
    LinearGradient(
      colors: gradientColors,
      startPoint: .top,
      endPoint: .bottom
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .opacity(0.3)
  }

  var body: some View {
    suggestion.suggestionImage
      .resizable()
      .aspectRatio(1, contentMode: .fill)
      .frame(height: 96)
      .overlay(gradientOverlay)
      .overlay(alignment: .bottomLeading) {
        Text(LocalizedStringKey(suggestion.rawValue.capitalized))
          .padding(12)
          .foregroundColor(.white)
          .font(.headline)
      }
      .cornerRadius(16)
  }
}

struct AnimalTypeSuggestionView_Previews: PreviewProvider {
  static var previews: some View {
    AnimalTypeSuggestionView(suggestion: .cat)
      .previewLayout(.sizeThatFits)

    AnimalTypeSuggestionView(suggestion: .cat)
      .previewLayout(.sizeThatFits)
      .environment(\.locale, Locale(identifier: "es"))
      .previewDisplayName("Spanish Locale")
  }
}
