//
//  NetworkService.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 27/09/2023.
//

import Foundation

// I should split this later to this one be responsable for decode the request itself and return
// And create a HttpClient responsable for make the request itself
protocol NetworkService {
    func request(with urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    func request( with urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void ) {
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                // TODO: Parse this error later
                completion(.failure(.unexpected))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // TODO: Validate status code range later
                completion(.failure(.unexpected))
                return
            }
            
            guard let data else {
                completion(.failure(.unexpected))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
