import Foundation
import XCTest
@testable import IOS_MovieRecommendation

class CardViewControllerBuilderTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let builder = CardViewController(networkService: networkService)

        // Then
        XCTAssertNotNil(builder.networkService)
        XCTAssertNotNil(builder.view)
    }

    func testSetupLayers() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let builder = CardViewController(networkService: networkService)

        // Then
        builder.exposePrivateSetupLayers()
    }

    func testMovieLiked() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let builder = CardViewController(networkService: networkService)

        // Then
        builder.exposePrivateMovieLiked()
    }

    func testMovieDisliked() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let builder = CardViewController(networkService: networkService)

        // Then
        builder.exposePrivateMovieDisliked()
    }

    func testNextPoster() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let builder = CardViewController(networkService: networkService)

        // Then
        builder.exposePrivateNextPoster()
    }
}
