import Foundation

struct CreateRoom: Decodable {
    let id: String
    let slug: String
    let creator: String
    let users: [String]
    let status: String
}

