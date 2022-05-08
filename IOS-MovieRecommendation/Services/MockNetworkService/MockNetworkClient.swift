//
//  MockNetworkClientImp.swift
//  IOS-MovieRecommendation
//
//  Created by Kamil on 12.03.2022.
//

import Foundation

final class MockNetworkService: NetworkService {
    func join(token: String, slug: String, completion: @escaping (Result<JoinRoom, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(JoinRoom(id: "mock", slug: "mock", creator: "mock", users: ["mock"], status: "mock")))
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
    
    func startRoom(token: String, slug: String, completion: @escaping (Result<StartRoom, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(StartRoom(id: "mock", slug: "mock", creator: "mock", users: ["mock"], status: "mock")))
        return nil
    }
    
    func login(username: String, password: String, completion: @escaping (Result<[String : String], HTTPError>) -> Void) -> Cancellable? {
        completion(.success(["mock": "mock"]))
        return nil
    }
    
    func createRoom(token: String, completion: @escaping (Result<CreateRoom, HTTPError>) -> Void) -> Cancellable? {
        completion(.success(CreateRoom(id: "mock", slug: "mock", creator: "mock", users: ["mock"], status: "mock")))
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
    
    func register(username: String, password: String, completion: @escaping (Result<[String:String], HTTPError>) -> Void) -> Cancellable? {
        if true {
            completion(.success(["token":"qwdqwdqwd"]))
        } else {
            completion(.failure(.failed))
        }
        
        return nil
    }
}

