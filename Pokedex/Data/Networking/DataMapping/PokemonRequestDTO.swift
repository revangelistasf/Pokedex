import Foundation

struct PokemonRequestDTO: Encodable {
    let offset: Int
    let limit: Int
}
