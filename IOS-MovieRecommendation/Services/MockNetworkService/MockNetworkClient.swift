//
//  MockNetworkClientImp.swift
//  IOS-MovieRecommendation
//
//  Created by Kamil on 12.03.2022.
//

import Foundation

final class MockNetworkService: NetworkService {

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

