import Foundation

struct RoomDTO: Decodable {
    let id: String
    let slug: String
    let creator: String
    let users: [String]
    let status: String
}

enum RoomStatus: Decodable {
    case Created
    case Started
    case Abandoned
}
