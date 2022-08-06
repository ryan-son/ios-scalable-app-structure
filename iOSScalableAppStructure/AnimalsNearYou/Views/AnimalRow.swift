//
//  AnimalRow.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import SwiftUI

struct AnimalRow: View {

  let animal: AnimalEntity

  var animalType: String {
    return animal.type ?? ""
  }

  var animalBreedAndType: String {
    return "\(animal.breed) \(animalType)"
  }

  var body: some View {
    HStack {
      AsyncImage(
        url: animal.picture,
        content: { image in
          image.resizable()
        },
        placeholder: {
          RoundedRectangle(cornerRadius: 8)
            .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
            .background(Color.gray.opacity(0.1))
            .overlay {
              if animal.picture != nil {
                ProgressView()
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .background(.gray.opacity(0.1))
              } else {
                Text("No Image")
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

        Text(animalBreedAndType)
          .font(.callout)

        if let description = animal.desc {
          Text(description)
            .lineLimit(2)
            .font(.footnote)
        }

        HStack {
          Text(animal.age.rawValue)
            .modifier(AnimalAttributesCard(color: animal.age.color))

          Text(animal.gender.rawValue)
            .modifier(AnimalAttributesCard(color: .pink))
        }
      }
      .lineLimit(1)
    }
  }
}

struct AnimalRow_Previews: PreviewProvider {
  static var previews: some View {
    if let animal = CoreDataHelper.testAnimalEntity() {
      AnimalRow(animal: animal)
    }
  }
}
