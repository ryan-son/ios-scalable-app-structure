//
//  AnimalAttributesCard.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/06.
//

import SwiftUI

struct AnimalAttributesCard: ViewModifier {

  let color: Color

  func body(content: Content) -> some View {
    return content
      .padding(4)
      .background(color.opacity(0.2))
      .cornerRadius(8)
      .foregroundColor(color)
      .font(.subheadline)
  }
}
