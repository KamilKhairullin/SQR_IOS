import Foundation

protocol NetworkService: AnyObject {
    
    @discardableResult
    func register(
        username: String,
        password: String,
        completion: @escaping (Result<[String:String], HTTPError>) -> Void
    ) -> Cancellable?
}
