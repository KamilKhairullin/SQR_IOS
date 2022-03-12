import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let coordinator = AppCoordinator()
        window?.rootViewController = coordinator.tapBarController
        window?.makeKeyAndVisible()
        return true
    }
}
