//
//  Movie Model.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 21/03/2023.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let imDBID, title, fullTitle, type: String
    let year: String
    let directors, writers: Directors
    let actors: [Actor]
    let others: [Directors]
    let errorMessage: String

    enum CodingKeys: String, CodingKey {
        case imDBID = "imDbId"
        case title, fullTitle, type, year, directors, writers, actors, others, errorMessage
    }
}

// MARK: - Actor
struct Actor: Codable {
    let id: String
    let image: String
    let name, asCharacter: String
}

// MARK: - Directors
struct Directors: Codable {
    let job: String
    let items: [ItemSearch]
}

// MARK: - Item
struct ItemSearch: Codable {
    let id, name, description: String
}
