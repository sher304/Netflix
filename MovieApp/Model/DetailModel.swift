//
//  SearchModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 23/03/2023.
//

import Foundation

// MARK: - SearchModel
struct DetailModel: Codable {
    let imDBID, title, fullTitle, type: String
    let year: String
    let items: [DetailItem]
    let errorMessage: String

    enum CodingKeys: String, CodingKey {
        case imDBID = "imDbId"
        case title, fullTitle, type, year, items, errorMessage
    }
}

// MARK: - Item
struct DetailItem: Codable {
    let title: String
    let image: String
}
