//
//  URLFactory.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation


struct URLFactory {
    
    
    private let baseURL: URL
    let getTopMovies: URL
    
    init(baseURL: URL = URL(string: "https://imdb-api.com/en/API/")!) {
        self.baseURL = baseURL
        self.getTopMovies = URL(string: baseURL.appendingPathComponent("Top250Movies/k_cd0ge5lq").description)!
    }
}
