//
//  Network.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation
import Alamofire

protocol NetwrokService {
//    func getMovies(completion: @escaping(Movies) ->Void )
//    func getMovie(id: String?, completion: @escaping(Movie) -> Void )
    
    func getAllTest(completion: @escaping(TestAll) -> Void)
}

class Network: NetwrokService {
    
    //    static func baseRequest<T: Codable>(url: URLRequest, method: String, completion: @escaping(Result<T, Error>) -> Void){
    //        if url == nil{
    //            DispatchQueue.main.async {
    //                completion(.failure(NetworkError.WrongURL))
    //            }
    //            return
    //        }
    //        var request = URLRequest(url: url.url!)
    //        request.httpMethod = method.uppercased()
    //        AF.request(url).response { responce in
    //            guard let data = responce.data else {
    //                completion(.failure(NetworkError.NilData))
    //                return
    //            }
    //            do {
    //                let jsonObj = try JSONDecoder().decode(T.self, from: data)
    //                DispatchQueue.main.async {
    //                    completion(.success(jsonObj))
    //                }
    //            } catch{
    //                DispatchQueue.main.async {
    //                    completion(.failure(error))
    //                }
    //            }
    //        }
    //    }
    
//    func getMovies(completion: @escaping (Movies) -> Void) {
//        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_cd0ge5lq/") else { return }
//        AF.request(url).response { responce in
//            DispatchQueue.main.async {
//                guard let data = responce.data else { return }
//                guard let jsonOBJ = try? JSONDecoder().decode(Movies.self, from: data) else { return }
//                completion(jsonOBJ)
//            }
//        }
//    }
//    
//    func getMovie(id: String?, completion: @escaping(Movie) -> Void ){
//        guard let url = URL(string: "https://imdb-api.com/en/API/FullCast/k_cd0ge5lq/\(id ?? "tt0110413")") else { return }
//        print(url)
//        AF.request(url).response { responce in
//            DispatchQueue.main.async {
//                guard let data = responce.data else { return }
//                print(data)
//                print(String(data: data, encoding: .utf8))
//                guard let jsonObj = try? JSONDecoder().decode(Movie.self, from: data) else { return }
//                print(jsonObj)
//                completion(jsonObj)
//            }
//        }
//    }
    
    func getAllTest(completion: @escaping(TestAll) -> Void){
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else { return }
        AF.request(url).response { responce in
            guard let data = responce.data else { return }
            guard let jsonObj = try? JSONDecoder().decode(TestAll.self, from: data) else { return }
            completion(jsonObj)
        }
    }
    
}
