//
//  AnimalsNearYouView.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/31.
//

import SwiftUI

struct AnimalsNearYouView: View {
  var body: some View {
    Text("TODO: Animals Near You")
  }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AnimalsNearYouView()
    }
    .previewLayout(.sizeThatFits)
    .previewDisplayName("iPhone SE (2nd generation)")

    NavigationView {
      AnimalsNearYouView()
    }
    .previewDevice("iPhone 12 Pro")
    .previewDisplayName("iPhone 12 Pro")
  }
}
