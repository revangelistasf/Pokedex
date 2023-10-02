//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 26/09/2023.
//

import Foundation

protocol PokemonRepository {
    func fetchPokemonList(
        query: PokemonQuery,
        completion: @escaping (Result<PokemonPagedResult, Error>) -> Void
    )
}
