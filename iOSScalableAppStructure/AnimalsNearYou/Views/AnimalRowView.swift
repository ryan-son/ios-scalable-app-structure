//
//  AnimalRowView.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import SwiftUI

struct AnimalRowView: View {

  let animal: AnimalEntity

  var body: some View {
    HStack {
      AsyncImage(
        url: animal.picture,
        content: { image in
          image.resizable()
        },
        placeholder: {
          Image(systemName: "swift")
            .resizable()
            .overlay {
              if animal.picture != nil {
                ProgressView()
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .background(.gray.opacity(0.4))
              }
            }
        }
      )
      .aspectRatio(contentMode: .fit)
      .frame(width: 112, height: 112)
      .cornerRadius(8)

      VStack(alignment: .leading) {
        Text(animal.name ?? "No Name Available")
          .multilineTextAlignment(.center)
          .font(.title3)
      }
      .lineLimit(1)
    }
  }
}

struct AnimalRow_Previews: PreviewProvider {
  static var previews: some View {
    if let animal = CoreDataHelper.testAnimalEntity() {
      AnimalRowView(animal: animal)
    }
  }
}
