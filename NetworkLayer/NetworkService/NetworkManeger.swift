//
//  NetworkManeger.swift
//  NetworkLayer
//
//  Created by hamid on 06.02.25.
//

import Foundation

class NetworkManeger{
    
    static let shared = NetworkManeger()
    private init() {}
    
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void){
        let task = URLSession.shared.dataTask(with: endpoint.request()){data,response,error in
                
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 else{
                completion(.failure(NSError(domain: "Invaild Response ", code: 0)))
                return
            }
            guard let data = data else{
                completion(.failure(NSError(domain: "Invaild Data ", code: 0)))
                return
            }
            do{
                let decodedata = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedata))
            }catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func getUser(completion: @escaping(Result<[user] , Error>)-> Void){
        let endpoint = Endpoint.GetUsers
        request(endpoint, completion: completion )
    }
    func getcomments(completion: @escaping(Result<Commitarray , Error>)-> Void){
        let endpoint = Endpoint.comments
        request(endpoint, completion: completion )
    }
}
