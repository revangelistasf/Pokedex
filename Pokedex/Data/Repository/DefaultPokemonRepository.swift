//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 26/09/2023.
//

import Foundation

final class DefaultPokemonRepository {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultPokemonRepository: PokemonRepository {
    func fetchPokemonList(query: PokemonQuery, completion: @escaping (Result<PokemonPagedResult, Error>) -> Void) {
        guard let url = URL(string: query.queryString) else {
            completion(.failure(RepositoryError.unexpected))
            return
        }
        let urlRequest = URLRequest(url: url)
        networkService.request(with: urlRequest) { (result: Result<PokemonPagedResult, NetworkError>) in
            switch result {
            case .success(let pokemonPagedResult):
                completion(.success(pokemonPagedResult))
            case .failure:
                completion(.failure(RepositoryError.unexpected))
            }
        }
    }
}

enum RepositoryError: Error {
    case unexpected
}
