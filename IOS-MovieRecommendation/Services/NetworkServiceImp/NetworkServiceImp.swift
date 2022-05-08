import Foundation
final class NetworkServiceImp: NetworkService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    @discardableResult
    func register(
        username: String,
        password: String,
        completion: @escaping (Result<[String:String], HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: createRegistrationRequest(username: username, password: password), completion: completion)
    }
    
    @discardableResult
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<[String:String], HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: createLoginRequest(username: username, password: password), completion: completion)
    }
    
    @discardableResult
    func createRoom(
        token: String,
        completion: @escaping (Result<CreateRoom, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: createRoomRequest(token: token), completion: completion)
    }
    
    @discardableResult
    func startRoom(
        token: String,
        slug: String,
        completion: @escaping (Result<StartRoom, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: startRoomRequest(token: token, slug: slug), completion: completion)
    }
    
    @discardableResult
    func join(
        token: String,
        slug: String,
        completion: @escaping (Result<JoinRoom, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: joinRoomRequest(token: token, slug: slug), completion: completion)
    }
    
    @discardableResult
    func like(
        token: String,
        slug: String,
        movieId: String,
        completion: @escaping (Result<Bool, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: likeRequest(token: token, slug: slug, movieId: movieId), completion: completion)
    }
    
    @discardableResult
    func drop(
        token: String,
        slug: String,
        completion: @escaping (Result<Bool, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: dropRequest(token: token, slug: slug), completion: completion)
    }

    private func createRegistrationRequest(username: String, password: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/user/register",
            headers:
            [
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding"
            ],
            body: try? JSONSerialization.data(withJSONObject:
                [
                    "username": username,
                    "password": password
                ]
            ),
            httpMethod: .post
        )
    }
    
    
    private func createLoginRequest(username: String, password: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/user/login",
            headers:
            [
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding"
            ],
            body: try? JSONSerialization.data(withJSONObject:
                [
                    "username": username,
                    "password": password
                ]
            ),
            httpMethod: .post
        )
    }
    
    private func createRoomRequest(token: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/room/create",
            headers:
            [
                "Bearer \(token)": "Authorization"
            ],
            httpMethod: .post
        )
    }
    
    private func startRoomRequest(token: String, slug: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/room/\(slug)/start",
            headers:
            [
                "Bearer \(token)": "Authorization"
            ],
            httpMethod: .post
        )
    }
    
    private func joinRoomRequest(token: String, slug: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/room/\(slug)/join",
            headers:
            [
                "Bearer \(token)": "Authorization"
            ],
            httpMethod: .post
        )
    }
    
    private func likeRequest(token: String, slug: String, movieId: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/room/\(slug)/like",
            headers:
            [
                "Bearer \(token)": "Authorization"
            ],
            body: try? JSONSerialization.data(withJSONObject:
                [
                    "movieId": movieId
                ]
            ),
            httpMethod: .post
        )
    }
    
    private func dropRequest(token: String, slug: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/room/\(slug)/drop",
            headers:
            [
                "Bearer \(token)": "Authorization"
            ],
            httpMethod: .post
        )
    }
}
