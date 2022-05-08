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
    
    @discardableResult
    func join(
        token: String,
        slug: String,
        completion: @escaping (Result<JoinRoom, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func like(
        token: String,
        slug: String,
        movieId: String,
        completion: @escaping (Result<Bool, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func drop(
        token: String,
        slug: String,
        completion: @escaping (Result<Bool, HTTPError>) -> Void
    ) -> Cancellable?
}
