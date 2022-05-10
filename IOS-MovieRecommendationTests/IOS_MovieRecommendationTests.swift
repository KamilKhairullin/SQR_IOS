import XCTest
@testable import IOS_MovieRecommendation

class UnauthorizedPageViewControllerBuilderTest: XCTestCase {

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
        let builder = UnauthorizedPageViewController(networkService: networkService)

        // Then
        XCTAssertNil(builder.appCoordinator)
        XCTAssertNotNil(builder.view)
    }

}
