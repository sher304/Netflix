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
    //    func getMovie(id: String?, completion: @escaping(SearchModel) -> Void )
    
    func getAllTest(completion: @escaping(TestAll) -> Void)
    
}

class Network: NetwrokService {
    
    //        func getMovies(completion: @escaping (Movies) -> Void) {
    //            guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_cd0ge5lq/") else { return }
    //            AF.request(url).response { responce in
    //                DispatchQueue.main.async {
    //                    guard let data = responce.data else { return }
    //                    guard let jsonOBJ = try? JSONDecoder().decode(Movies.self, from: data) else { return }
    //                    completion(jsonOBJ)
    //                }
    //            }
    //        }
    //
    //        func getMovie(id: String?, completion: @escaping(SearchModel) -> Void ){
    //            guard let url = URL(string: "https://imdb-api.com/en/API/FullCast/k_cd0ge5lq/\(id ?? "tt0110413")") else { return }
    //            print(url)
    //            AF.request(url).response { responce in
    //                DispatchQueue.main.async {
    //                    guard let data = responce.data else { return }
    //                    guard let jsonObj = try? JSONDecoder().decode(SearchModel.self, from: data) else {
    //                        print("error")
    //                        return }
    //                    print(jsonObj)
    //                    completion(jsonObj)
    //                }
    //            }
    //        }
    
    func getAllTest(completion: @escaping(TestAll) -> Void){
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else { return }
        AF.request(url).response { responce in
            DispatchQueue.main.async {
                guard let data = responce.data else { return }
                guard let jsonObj = try? JSONDecoder().decode(TestAll.self, from: data) else { return }
                completion(jsonObj)
            }
        }
    }
    
    
    static func getCharacter<T: Codable>(id: String, method: String, completion: @escaping(Result<T, Error>) -> Void){
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else { return }
        
        AF.request(url).response { responce in
            DispatchQueue.main.async {
                do{
                    guard let data = responce.data else { return }
                    guard let jsonObj = try? JSONDecoder().decode(T.self, from: data) else {
                        print("ERROR NETOWRK")
                        return }
                    completion(.success(jsonObj))
                }catch{
                    print("ERRORR")
                    completion(.failure(Error.self as! Error))
                }
                
            }
        }
        
    }
}
