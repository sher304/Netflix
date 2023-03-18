//
//  Movies Model.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 18/03/2023.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let items: [Item]
    let errorMessage: String
}

// MARK: - Item
struct Item: Codable {
    let id, rank, title, fullTitle: String
    let year: String
    let image: String
    let crew, imDBRating, imDBRatingCount: String

    enum CodingKeys: String, CodingKey {
        case id, rank, title, fullTitle, year, image, crew
        case imDBRating = "imDbRating"
        case imDBRatingCount = "imDbRatingCount"
    }
}
