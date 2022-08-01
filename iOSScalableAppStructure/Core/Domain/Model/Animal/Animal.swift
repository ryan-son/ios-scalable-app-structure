//
//  Animal.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation

/// - [Get Animals - API Docs](https://www.petfinder.com/developers/v2/docs/#get-animals)
/// - [Get Animal - API Docs](https://www.petfinder.com/developers/v2/docs/#get-animal)
struct Animal: Decodable {
  var id: Int?
  let organizationId: String?
  let url: URL?
  let type: String
  let species: String?
  var breeds: Breed
  var colors: ApiColors
  let age: Age
  let gender: Gender
  let size: Size
  let coat: Coat?
  let name: String
  let description: String?
  let photos: [PhotoSizes]
  let videos: [VideoLink]
  let status: AdoptionStatus
  var attributes: AnimalAttributes
  var environment: AnimalEnvironment?
  let tags: [String]
  var contact: Contact
  let publishedAt: String?
  let distance: Double?
  var ranking: Int? = 0

  var picture: URL? {
    return photos.first?.medium ?? photos.first?.large
  }
}

extension Animal: Identifiable {}
