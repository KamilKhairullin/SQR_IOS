import Foundation
import UIKit

final class NetworkServiceImp: NetworkService {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    // MARK: - POST

    @discardableResult
    func register(
        credentials: UserDTO,
        completion: @escaping (Result<TokenDTO, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: createRegistrationRequest(credentials: credentials), completion: completion)
    }

    @discardableResult
    func login(
        credentials: UserDTO,
        completion: @escaping (Result<TokenDTO, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: createLoginRequest(credentials: credentials), completion: completion)
    }

    @discardableResult
    func createRoom(
        token: String,
        completion: @escaping (Result<RoomDTO, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: createRoomRequest(token: token), completion: completion)
    }

    @discardableResult
    func startRoom(
        token: String,
        slug: String,
        completion: @escaping (Result<RoomDTO, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: startRoomRequest(token: token, slug: slug), completion: completion)
    }

    @discardableResult
    func join(
        token: String,
        slug: String,
        completion: @escaping (Result<RoomDTO, HTTPError>) -> Void
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

    // MARK: - GET

    @discardableResult
    func movieInfo(
        token: String,
        movieId: String,
        completion: @escaping (Result<MovieDTO, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: getMovieRequest(token: token, movieId: movieId), completion: completion)
    }

    func roomStats(
        token: String,
        slug: String,
        completion: @escaping (Result<RoomStatsDTO, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: getRoomStatsRequest(token: token, slug: slug), completion: completion)
    }

    func recommend(
        token: String,
        slug: String,
        completion: @escaping (Result<MovieDTO, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: getRecommendRequest(token: token, slug: slug), completion: completion)
    }

    func info(
        token: String,
        slug: String,
        completion: @escaping (Result<RoomDTO, HTTPError>) -> Void
    ) -> Cancellable? {
        networkClient.processRequest(request: getRoomInfoRequest(token: token, slug: slug), completion: completion)
    }
    // MARK: - Private methods

    private func createRegistrationRequest(credentials: UserDTO) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/user/register",
            headers:
            [
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding"
            ],
            body: try? JSONSerialization.data(withJSONObject:
                [
                    "username": credentials.login,
                    "password": credentials.password
                ]
            ),
            httpMethod: .post
        )
    }

    private func createLoginRequest(credentials: UserDTO) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/user/login",
            headers:
            [
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding"
            ],
            body: try? JSONSerialization.data(withJSONObject:
                [
                    "username": credentials.login,
                    "password": credentials.password
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
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding",
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
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding",
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
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding",
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
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding",
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
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding",
                "Bearer \(token)": "Authorization"
            ],
            httpMethod: .post
        )
    }

    private func getMovieRequest(token: String, movieId: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/movies/\(movieId)",
            headers:
            [
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding",
                "Bearer \(token)": "Authorization"
            ]
        )
    }

    private func getRoomStatsRequest(token: String, slug: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/room/\(slug)/stats",
            headers:
            [
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding",
                "Bearer \(token)": "Authorization"
            ]
        )
    }

    private func getRecommendRequest(token: String, slug: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/room/\(slug)/recommend",
            headers:
            [
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding",
                "Bearer \(token)": "Authorization"
            ]
        )
    }

    private func getRoomInfoRequest(token: String, slug: String) -> HTTPRequest {
        HTTPRequest(
            route: "http://proxyman.local:8080/room/\(slug)/info",
            headers:
            [
                "application/json": "Content-Type",
                "gzip, deflate": "Accept-Encoding",
                "Bearer \(token)": "Authorization"
            ]
        )
    }
}
