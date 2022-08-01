//
//  AnimalsContainer.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

import Foundation


/**
Domain model for getting animals response

 {
    "animals": [
       // animals
    ],
    "pagination": {
       // pagination data
    }
 }
*/
struct AnimalsContainer: Decodable {
  let animals: [Animal]
  let pagination: Pagination
}
