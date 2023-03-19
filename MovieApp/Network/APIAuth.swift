//
//  APIAuth.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation


protocol APIAuthDelegate{
    
    func getTopMovies(completion: @escaping(Result<Movies, Error>) -> Void)
    
}

class APIAuth: APIAuthDelegate {
    
    let urlFactory = URLFactory()
    
    func getTopMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
        let url = URLRequest(url: urlFactory.getTopMovies)
        NetworkService.baseRequest(url: url, method: "GET", completion: completion)
    }
}
