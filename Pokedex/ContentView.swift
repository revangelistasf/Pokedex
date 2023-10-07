//
//  ContentView.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 18/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    let pokemonRepository = DefaultPokemonRepository(networkService: DefaultNetworkService())
    
    var body: some View {
        Button("Get Async Pokemons") {

        }.task {
            await getPokemons()
        }
    }
    
    func getPokemons() async {
        DispatchQueue.main.async {
            let pokemonPagedResult = pokemonRepository.fetchPokemonList(query: PokemonQuery(page: 0, quantityResultsPerPage: 30)) { result in
                print(result)
            }
            
            print(pokemonPagedResult)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
