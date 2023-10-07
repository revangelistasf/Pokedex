import Foundation

struct PokemonQuery {
    let page: Int
    let quantityResultsPerPage: Int
    
    var offset: Int {
        page * quantityResultsPerPage
    }
}
