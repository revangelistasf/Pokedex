import Foundation

protocol FetchPokemonsUseCase {
    func execute(
        requestValue: FetchPokemonsUseCaseRequestValue,
        completion: @escaping (Result<PokemonPagedResult, Error>) -> Void
    )
}

final class DefaultFetchPokemonsUseCase: FetchPokemonsUseCase {
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository 
    }
    
    func execute(
        requestValue: FetchPokemonsUseCaseRequestValue,
        completion: @escaping (Result<PokemonPagedResult, Error>) -> Void
    )  {
        pokemonRepository.fetchPokemonList(query: PokemonQuery(page: requestValue.page, quantityResultsPerPage: requestValue.pokemonsPerPage)) { result in
            
        }
    }
}

struct FetchPokemonsUseCaseRequestValue {
    let page: Int
    let pokemonsPerPage: Int = 30
}
