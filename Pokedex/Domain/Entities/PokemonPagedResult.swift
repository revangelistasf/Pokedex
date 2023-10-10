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

