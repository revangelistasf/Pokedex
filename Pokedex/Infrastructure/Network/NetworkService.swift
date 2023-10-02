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
    func request<T: Decodable>(with urlRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    func request<T>(
        with urlRequest: URLRequest,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) where T : Decodable {
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
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                // TODO: Parse this error later
                completion(.failure(.unexpected))
            }
        }
        
        task.resume()
    }
}
