import Foundation

struct RoomStatsDTO: Decodable {
    let matchedMovies: [String]
    let ranking: [Ranking]
}

struct Ranking: Decodable {
    let movieId: String
    let likedUsers: [String]
}

