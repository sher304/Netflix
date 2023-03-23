//
//  SearchModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 23/03/2023.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let searchType: SearchTypeEnum
    let expression: String
    let results: [ResultSearch]
    let errorMessage: String
}

// MARK: - Result
struct ResultSearch: Codable {
    let id: String
    let resultType: SearchTypeEnum
    let image: String
    let title, description: String
}

enum SearchTypeEnum: String, Codable {
    case title = "Title"
}
