import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

            let tabBarApperance = UITabBarAppearance()
            tabBarApperance.configureWithTransparentBackground()
            tabBarApperance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGray]
            tabBarApperance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: ColorPalette.customYellow]
            tabBarApperance.stackedLayoutAppearance.normal.iconColor = .systemGray
            tabBarApperance.stackedLayoutAppearance.selected.iconColor = ColorPalette.customYellow

            UITabBar.appearance().standardAppearance = tabBarApperance
            UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        }
        
        let unauthorizedPage = UnauthorizedPageViewController()
        let authorizedPage = AuthorizedPageViewController()
        let cardViewController = CardViewController()
        let ratedCollectionViewController = RatedCollectionViewController()
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        
        let appCoordinator = AppCoordinator(
            unauthorizedPage: unauthorizedPage,
            authorizedPage: authorizedPage,
            cardViewController: cardViewController,
            ratedCollectionViewController: ratedCollectionViewController,
            networkSerivce: networkService,
            appDelegate: self
        )
        
        unauthorizedPage.appCoordinator = appCoordinator
        authorizedPage.appCoordinator = appCoordinator
        cardViewController.moviewCollectionDelegate = ratedCollectionViewController
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [UIViewController()]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator.getStartingPage()
        return true
    }
}

extension AppDelegate: Configurable {
    func configure(with viewController: UIViewController) {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        window?.rootViewController = navigationController
    }
}
