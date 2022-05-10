import Foundation
import XCTest
@testable import IOS_MovieRecommendation

class RatedCollectionViewControllerBuilderTest: XCTestCase {

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
        let builder = RatedCollectionViewController(networkService: networkService)

        // Then
        XCTAssertNotNil(builder.networkService)
        XCTAssertNotNil(builder.view)
    }

    func testSetupLayers() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let builder = RatedCollectionViewController(networkService: networkService)

        builder.exposePrivateSetupLayers()
    }

    func testSetupViews() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let builder = RatedCollectionViewController(networkService: networkService)

        builder.exposePrivateSetupViews()
    }

    func testSetupTitles() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let builder = RatedCollectionViewController(networkService: networkService)

        builder.exposePrivateSetupTitles()
    }

    func testSetupCards() {
        // Given
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let builder = RatedCollectionViewController(networkService: networkService)

        builder.exposePrivateSetupCards()
    }
}
