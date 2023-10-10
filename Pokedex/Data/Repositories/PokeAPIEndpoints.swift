import Foundation

struct PokeAPIEndpoints {
    private static let scheme = "https"
    private static let host = "pokeapi.co"
    private static let version = "/api/v2/"
    private static let baseURL = PokeAPIEndpoints.scheme + PokeAPIEndpoints.host + PokeAPIEndpoints.version
    
    static func getPokemons(with pokemonListRequestDTO: PokemonListRequestDTO) -> URLRequest {
        // TODO: How I can create this without optional url, maybe not using URLComponents?
        let endpoint = "pokemon/"
        var urlComponents = URLComponents()
        urlComponents.scheme = PokeAPIEndpoints.scheme
        urlComponents.host = PokeAPIEndpoints.host
        urlComponents.path = PokeAPIEndpoints.version + endpoint
        urlComponents.queryItems = pokemonListRequestDTO.toURLQueryItems()
        return URLRequest(url: urlComponents.url!)
    }
    
    static func getPokemon(with pokemonRequestDTO: PokemonRequestDTO) -> URLRequest {
        var endpoint = "pokemon/"
        if let id = pokemonRequestDTO.id {
            endpoint += String(id)
        } else if let name = pokemonRequestDTO.name {
            endpoint += name
        }
        
        let baseURL = PokeAPIEndpoints.baseURL + endpoint
        return URLRequest(url: URL(string: baseURL)!)
        
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
