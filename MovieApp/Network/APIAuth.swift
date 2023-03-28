//
//  APIAuth.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation

class APIAuth {
    
    func getTopMovies(id: String, completion: @escaping (Result<DetailModel, Error>) -> Void) {
        Network.getMovies(id: id, method: "GET", completion: completion)
    }
    
    func getTopMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
        Network.getMovies(method: "GET", completion: completion)
    }
}
