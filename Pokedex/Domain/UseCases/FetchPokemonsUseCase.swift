//
//  GetPokemons.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 26/09/2023.
//

import Foundation

protocol FetchPokemonsUseCase {
    func execute(
        requestValue: FetchPokemonsUseCaseRequestValue,
        completion: @escaping (Result<[Pokemon], Error>) -> Void
    )
}

final class DefaultFetchPokemonsUseCase: FetchPokemonsUseCase {
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    func execute(
        requestValue: FetchPokemonsUseCaseRequestValue,
        completion: @escaping (Result<[Pokemon], Error>) -> Void) {
            pokemonRepository.fetchPokemonList(query: requestValue.query, completion: completion)
        
    }
}

protocol PokemonRepository {
    func fetchPokemonList(
        query: PokemonQuery,
        completion: @escaping (Result<[Pokemon], Error>) -> Void
    )
}

struct FetchPokemonsUseCaseRequestValue {
    let query: PokemonQuery
}

struct PokemonQuery {
    
}
