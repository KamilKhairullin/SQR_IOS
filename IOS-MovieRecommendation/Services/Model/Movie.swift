import UIKit

struct Movie: Codable {
    let id: String?
    let title: String?
    let posterURL: String?
    let description: String?
    let rating: Float?
    let ratingBorder: Float?
}

struct MovieCard {
    let movie: MovieDTO
    let image: UIImage
}
