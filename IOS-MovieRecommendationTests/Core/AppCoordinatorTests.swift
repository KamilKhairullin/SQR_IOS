import Foundation
import XCTest
@testable import IOS_MovieRecommendation

class AppCoordinatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetStartingPage() {
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let unauthorizedPage = UnauthorizedPageViewController(networkService: networkService)
        let authorizedPage = AuthorizedPageViewController(networkService: networkService)
        let cardViewController = CardViewController(networkService: networkService)
        let ratedCollectionViewController = RatedCollectionViewController(networkService: networkService)

        let appCoordinator = AppCoordinator(
            unauthorizedPage: unauthorizedPage,
            authorizedPage: authorizedPage,
            cardViewController: cardViewController,
            ratedCollectionViewController: ratedCollectionViewController,
            networkSerivce: networkService,
            appDelegate: nil
        )

        appCoordinator.getStartingPage()
    }

    func testLoginSucceded() {
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let unauthorizedPage = UnauthorizedPageViewController(networkService: networkService)
        let authorizedPage = AuthorizedPageViewController(networkService: networkService)
        let cardViewController = CardViewController(networkService: networkService)
        let ratedCollectionViewController = RatedCollectionViewController(networkService: networkService)

        let appCoordinator = AppCoordinator(
            unauthorizedPage: unauthorizedPage,
            authorizedPage: authorizedPage,
            cardViewController: cardViewController,
            ratedCollectionViewController: ratedCollectionViewController,
            networkSerivce: networkService,
            appDelegate: nil
        )

        appCoordinator.loginSucceed(on: UIViewController(), with: "mock")
    }

    func testRegistrationSucceded() {
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let unauthorizedPage = UnauthorizedPageViewController(networkService: networkService)
        let authorizedPage = AuthorizedPageViewController(networkService: networkService)
        let cardViewController = CardViewController(networkService: networkService)
        let ratedCollectionViewController = RatedCollectionViewController(networkService: networkService)

        let appCoordinator = AppCoordinator(
            unauthorizedPage: unauthorizedPage,
            authorizedPage: authorizedPage,
            cardViewController: cardViewController,
            ratedCollectionViewController: ratedCollectionViewController,
            networkSerivce: networkService,
            appDelegate: nil
        )

        appCoordinator.registerSucceed(on: UIViewController(), with: "mock")
    }

    func testStartRoom() {
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let unauthorizedPage = UnauthorizedPageViewController(networkService: networkService)
        let authorizedPage = AuthorizedPageViewController(networkService: networkService)
        let cardViewController = CardViewController(networkService: networkService)
        let ratedCollectionViewController = RatedCollectionViewController(networkService: networkService)

        let appCoordinator = AppCoordinator(
            unauthorizedPage: unauthorizedPage,
            authorizedPage: authorizedPage,
            cardViewController: cardViewController,
            ratedCollectionViewController: ratedCollectionViewController,
            networkSerivce: networkService,
            appDelegate: nil
        )

        appCoordinator.startTheRoom(on: UIViewController())
    }

    func testWaitForOthers() {
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        let unauthorizedPage = UnauthorizedPageViewController(networkService: networkService)
        let authorizedPage = AuthorizedPageViewController(networkService: networkService)
        let cardViewController = CardViewController(networkService: networkService)
        let ratedCollectionViewController = RatedCollectionViewController(networkService: networkService)

        let appCoordinator = AppCoordinator(
            unauthorizedPage: unauthorizedPage,
            authorizedPage: authorizedPage,
            cardViewController: cardViewController,
            ratedCollectionViewController: ratedCollectionViewController,
            networkSerivce: networkService,
            appDelegate: nil
        )

        appCoordinator.waitingForOthers(on: UIViewController())
    }
}
