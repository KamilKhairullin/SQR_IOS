final class NetworkServiceImp: NetworkService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    @discardableResult
    func register(
        username: String,
        password: String,
        completion: @escaping (Result<String, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: createRegistrationRequest(id: 1), completion: completion)
    }
    
//    func like() {}
//
//    func dislike() {}
//
//    func getNextRecommendation(for id: Int, completion: @escaping (Result<Movie, NetworkError>) -> Void) {
//        networkClient.recieveData(
//            completion: completion
//        )
//    }
    
    private func createRegistrationRequest(id: Int) -> HTTPRequest {
        return HTTPRequest(route: "http://localhost:8080/user/register")
    }
}
