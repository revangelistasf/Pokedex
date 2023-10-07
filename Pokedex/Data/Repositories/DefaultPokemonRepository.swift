//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Roberto Evangelista on 26/09/2023.
//

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
        let pokemonDTO = PokemonRequestDTO(
            offset: query.offset,
            limit: query.quantityResultsPerPage
        )
        networkService.request(with: PokeAPIEndpoints.getPokemons(with: pokemonDTO)) { result in
            switch result {
            case .success(let success):
                let result = try! JSONDecoder().decode(PokemonPagedResult.self, from: success)
                completion(.success(result))
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
enum RepositoryError: Error {
    case unexpected
}


struct PokeAPIEndpoints {
    private static let scheme = "https"
    private static let host = "pokeapi.co"
    private static let version = "/api/v2/"
    
    static func getPokemons(with pokemonRequestDTO: PokemonRequestDTO) -> URLRequest {
        // TODO: How I can create this without optional url, maybe not using URLComponents?
        let endpoint = "pokemon/"
        var urlComponents = URLComponents()
        urlComponents.scheme = PokeAPIEndpoints.scheme
        urlComponents.host = PokeAPIEndpoints.host
        urlComponents.path = PokeAPIEndpoints.version + endpoint
        urlComponents.queryItems = pokemonRequestDTO.toURLQueryItems()
        return URLRequest(url: urlComponents.url!)
    }
}

private extension Encodable {
    func toURLQueryItems() -> [URLQueryItem]? {
        do {
            let data = try JSONEncoder().encode(self)
            let jsonDict = try JSONSerialization.jsonObject(with: data) as? [String : Any]
            return jsonDict?.compactMap { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        } catch {
            return []
        }
    }
}
