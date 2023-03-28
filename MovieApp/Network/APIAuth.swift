//
//  APIAuth.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation

class APIAuth {
    
    //MARK: Get All Movies
    func getTopMovies(id: String, completion: @escaping (Result<DetailModel, Error>) -> Void) {
        Network.getMovies(id: id, method: "GET", completion: completion)
    }
    
    //MARK: Get Movie By Id
    func getTopMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
        Network.getMovies(method: "GET", completion: completion)
    }
}
