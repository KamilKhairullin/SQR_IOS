import Foundation

protocol NetworkService: AnyObject {
    
    func like()
    
    func dislike()
    
    func getNextRecommendation(
        for id: Int,
        completion: @escaping (Result<Movie, NetworkError>) -> Void
    )
}

final class NetworkServiceImp: NetworkService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func like() {}
    
    func dislike() {}
    
    func getNextRecommendation(for id: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        networkClient.recieveData(
            completion: completion
        )
    }
}
