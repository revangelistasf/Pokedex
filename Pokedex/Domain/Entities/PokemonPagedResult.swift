//
//  PokemonPagedResult.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 01/10/2023.
//

import Foundation

struct PokemonPagedResult: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
    
    struct PokemonResult: Decodable {
        let name: URL
        let url: String
    }
}

