//
//  Breed.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

/// Accepts multiple values, e.g. breed=pug,samoyed.
/// - [Get Animal Breeds - API Docs](https://www.petfinder.com/developers/v2/docs/#get-animal-breeds)
struct Breed: Decodable {
  var id: Int?
  var primary: String?
  var secondary: String?
  var mixed: Bool?
  var unknown: Bool?
}
