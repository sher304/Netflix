//
//  APIAuth.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation

class APIAuth {

    func getTopMovies(id: String, completion: @escaping (Result<SingleTest, Error>) -> Void) {
        Network.getCharacter(id: id, method: "GET", completion: completion)
    }
}
