import Foundation

struct PokemonListRequestDTO: Encodable {
    let offset: Int
    let limit: Int
}
