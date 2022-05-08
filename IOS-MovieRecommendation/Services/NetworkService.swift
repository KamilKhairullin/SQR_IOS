import Foundation

protocol NetworkService: AnyObject {
    
    @discardableResult
    func register(
        username: String,
        password: String,
        completion: @escaping (Result<String, HTTPError>) -> Void
    ) -> Cancellable?
    
//    func like()
//
//    func dislike()
//
//    func getNextRecommendation(
//        for id: Int,
//        completion: @escaping (Result<Movie, NetworkError>) -> Void
//    )
}
