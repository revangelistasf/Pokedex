//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 26/09/2023.
//

import Foundation

final class DefaultPokemonRepository {
    
}

extension DefaultPokemonRepository: PokemonRepository {
    func fetchPokemonList(query: PokemonQuery, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        
    }
    
    
}
