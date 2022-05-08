import Foundation

protocol NetworkService: AnyObject {
    
    // MARK: - POST
    
    @discardableResult
    func register(
        credentials: UserDTO,
        completion: @escaping (Result<TokenDTO, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func login(
        credentials: UserDTO,
        completion: @escaping (Result<TokenDTO, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func createRoom(
        token: String,
        completion: @escaping (Result<RoomDTO, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func startRoom(
        token: String,
        slug: String,
        completion: @escaping (Result<RoomDTO, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func join(
        token: String,
        slug: String,
        completion: @escaping (Result<RoomDTO, HTTPError>) -> Void
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
    
    // MARK: - GET
    
    @discardableResult
    func movieInfo(
        token: String,
        movieId: String,
        completion: @escaping (Result<MovieDTO, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func roomStats(
        token: String,
        slug: String,
        completion: @escaping (Result<RoomStatsDTO, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func recommend(
        token: String,
        slug: String,
        completion: @escaping (Result<MovieDTO, HTTPError>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func info(
        token: String,
        slug: String,
        completion: @escaping (Result<RoomDTO, HTTPError>) -> Void
    ) -> Cancellable?
}
