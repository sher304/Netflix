//
//  Network.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation
import Alamofire

class NetworkService {
    
    static func baseRequest<T: Codable>(url: URLRequest, method: String, completion: @escaping(Result<T, Error>) -> Void){
        
        if url == nil{
            DispatchQueue.main.async {
                completion(.failure(NetworkError.WrongURL))
            }
            return
        }
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = method.uppercased()
        
        AF.request(url).response { responce in
            guard let data = responce.data else {
                completion(.failure(NetworkError.NilData))
                return
            }
            do {
                let jsonObj = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonObj))
                }
            } catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}



enum NetworkError: Error{
    case WrongURL
    case NilData
}
