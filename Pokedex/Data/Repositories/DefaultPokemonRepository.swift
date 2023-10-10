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
    func fetchPokemonList(
        query: PokemonQuery,
        completion: @escaping (Result<PokemonPagedResult, Error>) -> Void
    ) {
        let pokemonDTO = PokemonRequestDTO(
            offset: query.offset,
            limit: query.quantityResultsPerPage
        )
        networkService.request(with: PokeAPIEndpoints.getPokemons(with: pokemonDTO)) { result in
            switch result {
            case .success(let success):
                let result = try! JSONDecoder().decode(PokemonPagedResult.self, from: success)
                completion(.success(result))
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
