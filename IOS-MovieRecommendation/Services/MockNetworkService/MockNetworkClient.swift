//
//  MockNetworkClientImp.swift
//  IOS-MovieRecommendation
//
//  Created by Kamil on 12.03.2022.
//

 import Foundation

 final class MockNetworkService: NetworkService {
    func recommend(token: String, slug: String, completion: @escaping (Result<MovieDTO, HTTPError>) -> Void) -> Cancellable? {
        completion(
            .success(
                MovieDTO(
                    id: "mock",
                    name: "mock",
                    posterUrl: "mock",
                    description: "mock",
                    rating: Rating(kinopoisk: 0.0, imdb: 0.0, tmdb: 5.0),
                    genres: ["mock"],
                    actors: [
                        ActorDTO(name: "mock", photoUrl: "mock")
                    ]
                )
            )
        )
            return nil
    }
    
    func info(token: String, slug: String, completion: @escaping (Result<RoomDTO, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(RoomDTO(id: "mock", slug: "mock", creator: "mock", users: ["mock"], status: "started")))
        return nil
    }
    
    func roomStats(token: String, slug: String, completion: @escaping (Result<RoomStatsDTO, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(RoomStatsDTO(matchedMovies: ["1", "2"], ranking: [Ranking(movieId: "1", likedUsers: ["2"])])))
        return nil
    }
    
    func movieInfo(token: String, movieId: String, completion: @escaping (Result<MovieDTO, HTTPError>) -> Void) -> Cancellable? {
        completion(
            .success(
                MovieDTO(
                    id: "mock",
                    name: "mock",
                    posterUrl: "mock",
                    description: "mock",
                    rating: Rating(kinopoisk: 10, imdb: 10, tmdb: 10),
                    genres: ["mock"],
                    actors: [
                        ActorDTO(name: "Mock Mocker", photoUrl: "mock")
                    ]
                )
            )
        )
        return nil
    }
    
    func join(token: String, slug: String, completion: @escaping (Result<RoomDTO, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(RoomDTO(id: "mock", slug: "mock", creator: "mock", users: ["mock"], status: "started")))
        return nil
    }
    
    func like(token: String, slug: String, movieId: String, completion: @escaping (Result<Bool, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(true))
        return nil
    }
    
    func drop(token: String, slug: String, completion: @escaping (Result<Bool, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(true))
        return nil
    }
    
    func startRoom(token: String, slug: String, completion: @escaping (Result<RoomDTO, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(RoomDTO(id: "mock", slug: "mock", creator: "mock", users: ["mock"], status: "started")))
        return nil
    }
    
    func login(credentials: UserDTO, completion: @escaping (Result<TokenDTO, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(TokenDTO(token: "mock")))
        return nil
    }
    
    func createRoom(token: String, completion: @escaping (Result<RoomDTO, HTTPError>) -> Void) -> Cancellable? {
//        completion(.success(RoomDTO(id: "mock", slug: "mock", creator: "mock", users: ["mock"], status: "created")))
        return nil
    }
    

    private let networkClient: NetworkClient?
    private let mockData: [Movie]?
    
    init(networkClient: NetworkClient?) {
        self.networkClient = networkClient
        
        if let path = Bundle.main.path(forResource: "mock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Movie].self, from: data)
                self.mockData = jsonResult
            } catch {
                self.mockData = nil
                print("error parsing mock")
            }
        } else {
            self.mockData = nil
        }
    }
//
//    func like() {
//        print("You liked sucessefully")
//    }
//
//    func dislike() {
//        print("You disliked sucessefully")
//    }
    
    func getNextRecommendation(for id: Int, completion: @escaping (Result<Movie, HTTPError>) -> Void) {
        if let result = mockData?.randomElement() {
            completion(.success(result))
        } else {
            completion(.failure(.failed))
        }
    }
    
    func register(credentials: UserDTO, completion: @escaping (Result<TokenDTO, HTTPError>) -> Void) -> Cancellable? {
        if true {
            completion(.success(TokenDTO(token: "qwdqwdqwd")))
        } else {
            completion(.failure(.failed))
        }
        
        return nil
    }
 }

