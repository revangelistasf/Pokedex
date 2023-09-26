//
//  ContentView.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 18/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    let pokemonRepository = PokemonListRepository()
    
    var body: some View {
        Button("Get Async Pokemons") {

        }.task {
            await getPokemons()
        }
    }
    
    func getPokemons() async {
        let pokemons = try! await pokemonRepository.fetchPokemons(url: URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=60&offset=60.")!)
        print(pokemons)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
