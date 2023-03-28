//
//  Network.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation
import Alamofire

protocol NetwrokService {
    static func getMovies<T: Codable>(method: String, completion: @escaping(Result<T, Error>) -> Void)
    static func getMovies<T: Codable>(id: String, method: String, completion: @escaping(Result<T, Error>) -> Void)
}

class Network: NetwrokService {
    //MARK: Network Request Method
    static func getMovies<T>(method: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_cd0ge5lq/") else { return }
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
    
    //MARK: Network Request Method With Id
    static func getMovies<T: Codable>(id: String, method: String, completion: @escaping(Result<T, Error>) -> Void){
        guard let url = URL(string: "https://imdb-api.com/en/API/Images/k_cd0ge5lq/\(id)") else { return }
        print(url)
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
