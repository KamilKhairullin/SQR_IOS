import Foundation

protocol NetworkClient {
    func recieveData<T: Decodable>(
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) -> Cancellable?
}

protocol Cancellable {
    func cancel()
}
