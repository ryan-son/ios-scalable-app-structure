//
//  Pagination.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

struct Pagination: Decodable {
  let countPerPage: Int
  let totalCount: Int
  let currentPage: Int
  let totalPages: Int
}
