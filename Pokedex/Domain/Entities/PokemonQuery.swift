import Foundation

// TODO: Maybe this name is too dubious
struct PokemonQuery {
    let page: Int
    let quantityResultsPerPage: Int
    
    var offset: Int {
        page * quantityResultsPerPage
    }
}
