import Foundation
import XCTest
@testable import IOS_MovieRecommendation

class HTTPNetworkResponseTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test200() {

        let response = HTTPURLResponse(
            url: URL(string: "mock") ?? URL(fileURLWithPath: "mock"),
            statusCode: 200,
            httpVersion: "mock",
            headerFields: nil
        )

        let httpResponse = HTTPNetworkResponse.handleNetworkResponse(for: response)
        switch httpResponse {
        case .failure:
            XCTFail("Test failed")
        default:
            break
        }
    }

    func test401() {

        let response = HTTPURLResponse(
            url: URL(string: "mock") ?? URL(fileURLWithPath: "mock"),
            statusCode: 401,
            httpVersion: "mock",
            headerFields: nil
        )

        let httpResponse = HTTPNetworkResponse.handleNetworkResponse(for: response)
        switch httpResponse {
        case .success:
            XCTFail("Test failed")
        default:
            break
        }
    }

    func test400() {

        let response = HTTPURLResponse(
            url: URL(string: "mock") ?? URL(fileURLWithPath: "mock"),
            statusCode: 400,
            httpVersion: "mock",
            headerFields: nil
        )

        let httpResponse = HTTPNetworkResponse.handleNetworkResponse(for: response)
        switch httpResponse {
        case .success:
            XCTFail("Test failed")
        default:
            break
        }
    }

    func test501() {

        let response = HTTPURLResponse(
            url: URL(string: "mock") ?? URL(fileURLWithPath: "mock"),
            statusCode: 501,
            httpVersion: "mock",
            headerFields: nil
        )

        let httpResponse = HTTPNetworkResponse.handleNetworkResponse(for: response)
        switch httpResponse {
        case .success:
            XCTFail("Test failed")
        default:
            break
        }
    }

}
