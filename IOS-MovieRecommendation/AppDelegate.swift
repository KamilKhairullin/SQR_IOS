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
        
        let coordinator = AppCoordinator()
        window?.rootViewController = coordinator.tapBarController
        window?.makeKeyAndVisible()
        return true
    }
}
