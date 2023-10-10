import Foundation

protocol PokemonRepository {
    func fetchPokemonList(
        query: PokemonQuery,
        completion: @escaping (Result<PokemonPagedResult, Error>) -> Void
    )
    func fetchPokemon(by id: Int, completion: @escaping (Result<Pokemon, Error>) -> Void)
    func fetchPokemon(by name: String, completion: @escaping (Result<Pokemon, Error>) -> Void)
}
