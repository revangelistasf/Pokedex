//
//  Pokemon.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 26/09/2023.
//

import Foundation

struct Pokemon: Decodable {
    let id: String
    let name: String
}

struct PokemonPagedResult: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
}

struct PokemonResult: Decodable {
    let name: URL
    let url: String
}
