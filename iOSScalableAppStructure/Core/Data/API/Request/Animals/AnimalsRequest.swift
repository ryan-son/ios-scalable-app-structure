//
//  AnimalsRequest.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

enum AnimalsRequest: RequestProtocol {
  case getAnimalsWith(
    page: Int,
    latitude: Double?,
    longitude: Double?
  )
  case getAnimalsBy(
    name: String,
    age: String?,
    type: String?
  )

  var path: String {
    return "/v2/animals"
  }

  var urlParams: [String: String?] {
    switch self {
    case let .getAnimalsWith(page, latitude, longitude):
      var params = ["page": String(page)]

      if let latitude = latitude {
        params["latitude"] = String(latitude)
      }

      if let longitude = longitude {
        params["longitude"] = String(longitude)
      }

      params["sort"] = "random"
      return params

    case let .getAnimalsBy(name, age, type):
      var params: [String: String] = [:]

      if name.isNotEmpty {
        params["name"] = name
      }

      if let age = age {
        params["age"] = age
      }

      if let type = type {
        params["type"] = type
      }
      return params
    }
  }

  var requestType: RequestType {
    return .get
  }
}
