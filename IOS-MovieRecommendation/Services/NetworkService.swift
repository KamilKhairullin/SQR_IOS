import Foundation

protocol NetworkService: AnyObject {
    
    @discardableResult
    func register(
        username: String,
        password: String,
        completion: @escaping (Result<[String:String], HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<[String:String], HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func createRoom(
        token: String,
        completion: @escaping (Result<CreateRoom, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func startRoom(
        token: String,
        slug: String,
        completion: @escaping (Result<StartRoom, HTTPError>) -> Void
    ) -> Cancellable?
}
