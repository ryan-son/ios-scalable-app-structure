//
//  Organization.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/07/31.
//

/// Accepts multiple values, e.g. organization=[ID1],[ID2].
/// - [Get Organizations - API Docs](https://www.petfinder.com/developers/v2/docs/#get-organizations)
/// - [Get Organization - API Docs(https://www.petfinder.com/developers/v2/docs/#get-organization)
struct Organization: Decodable {
  var id: Int?
  var contact: Contact?
  /// Requires location to be set (default: 100, max: 500)
  var distance: Double?
}

struct Contact: Decodable {
  var id: Int?
  var email: String
  var phone: String?
  var address: Address?
}

struct Address: Codable {
  var id: Int?
  var address1: String?
  var address2: String?
  var city: String?
  var state: String?
  var postcode: String?
  var country: String?
}
