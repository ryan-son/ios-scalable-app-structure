//
//  SearchView.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/31.
//

import SwiftUI

struct SearchView: View {
  var body: some View {
    Text("TODO: Search")
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SearchView()
    }
    .previewLayout(.sizeThatFits)
    .previewDisplayName("iPhone SE (2nd generation)")

    NavigationView {
      SearchView()
    }
    .previewDevice("iPhone 12 Pro")
    .previewDisplayName("iPhone 12 Pro")
  }
}
