import Foundation

struct MovieDTO: Decodable {
    let id: String
    let name: String
    let posterUrl: String
    let description: String
    let rating: Rating
    let genres: [String]
    let actors: [ActorDTO]
}

struct Rating: Decodable {
    let kinopoisk: Double?
    let imdb: Double?
    let tmdb: Double?
}
