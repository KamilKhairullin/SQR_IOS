import Foundation
import XCTest
@testable import IOS_MovieRecommendation

class NetworkSerivceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)

        var result = false
        let exp = expectation(description: "aboba")

        networkService.login(credentials: UserDTO(login: "mock", password: "mock")) { response in
            switch response {
            case .success:
                result = true
            case let .failure(error):
                switch error {
                case .decodingFailed:
                    result = true
                default:
                    result = true
                }
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
        XCTAssertTrue(result)
    }

    func testRegister() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)

        var result = false
        let exp = expectation(description: "aboba")

        networkService.register(credentials: UserDTO(login: "mock", password: "mock")) { response in
            switch response {
            case .success:
                result = true
            case let .failure(error):
                switch error {
                case .decodingFailed:
                    result = true
                default:
                    result = true
                }
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
        XCTAssertTrue(result)
    }

    func testStartRoom() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)

        var result = false
        let exp = expectation(description: "aboba")

        networkService.startRoom(token: "mock", slug: "mock") { response in
            switch response {
            case .success:
                result = true
            case let .failure(error):
                switch error {
                case .decodingFailed:
                    result = true
                default:
                    result = true
                }
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
        XCTAssertTrue(result)
    }

    func testJoin() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)

        var result = false
        let exp = expectation(description: "aboba")

        networkService.join(token: "mock", slug: "mock") { response in
            switch response {
            case .success:
                result = true
            case let .failure(error):
                switch error {
                case .decodingFailed:
                    result = true
                default:
                    result = true
                }
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
        XCTAssertTrue(result)
    }

    func testLike() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)

        var result = false
        let exp = expectation(description: "aboba")

        networkService.like(token: "mock", slug: "mock", movieId: "mock") { response in
            switch response {
            case .success:
                result = true
            case let .failure(error):
                switch error {
                case .decodingFailed:
                    result = true
                default:
                    result = true
                }
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 10)
        XCTAssertTrue(result)
    }

}
