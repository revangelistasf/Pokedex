import Foundation

protocol FetchPokemonsUseCase {
    func execute(
        requestValue: FetchPokemonsUseCaseRequestValue,
        completion: @escaping (Result<PokemonPagedResult, Error>) -> Void
    )
}

final class DefaultFetchPokemonsUseCase: FetchPokemonsUseCase {
    private let pokemonRepository: PokemonRepository
    private var page: Int = 0
    private var pokemonsPerPage: Int = 30
    private var pokemons: [Pokemon] = []
    
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository 
    }
    
    func execute(
        requestValue: FetchPokemonsUseCaseRequestValue,
        completion: @escaping (Result<PokemonPagedResult, Error>) -> Void
    )  {
        let query = PokemonQuery(page: page, quantityResultsPerPage: pokemonsPerPage)
        pokemonRepository.fetchPokemonList(query: query) { [weak self] result in
            switch result {
            case .success(let pokemonPagedResult):
                self?.getPokemonInfo(from: pokemonPagedResult)
            case .failure(let error):
                // TODO: Show error screen
                print(error)
            }
        }
    }
    
    private func getPokemonInfo(from pokemonPagedResults: PokemonPagedResult) {
        for pokemonResults in pokemonPagedResults.results {
            
        }
    }
}

struct FetchPokemonsUseCaseRequestValue {
    
}
