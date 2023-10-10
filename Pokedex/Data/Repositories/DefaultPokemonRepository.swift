import Foundation

final class DefaultPokemonRepository {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultPokemonRepository: PokemonRepository {
    func fetchPokemonList(
        query: PokemonQuery,
        completion: @escaping (Result<PokemonPagedResult, Error>) -> Void
    ) {
        let pokemonsDTO = PokemonListRequestDTO(
            offset: query.offset,
            limit: query.quantityResultsPerPage
        )
        networkService.request(with: PokeAPIEndpoints.getPokemons(with: pokemonsDTO)) { result in
            switch result {
            case .success(let success):
                let result = try! JSONDecoder().decode(PokemonPagedResult.self, from: success)
                completion(.success(result))
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchPokemon(by id: Int, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
    }
    
    func fetchPokemon(by name: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
    }
}
