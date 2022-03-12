import UIKit

final class AppCoordinator {
    
    let tapBarController: UITabBarController = {
        let view = UITabBarController()
        view.tabBar.backgroundColor = ColorPalette.tabBarBackground
        return view
    }()

    init() {
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = .red
        redViewController.tabBarItem.title = "Red"
        redViewController.tabBarItem.image = .add
    
        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = .blue
        blueViewController.tabBarItem.title = "Blue"
        blueViewController.tabBarItem.image = .add
    
        let greenViewController = UIViewController()
        greenViewController.view.backgroundColor = .green
        greenViewController.tabBarItem.title = "Green"
        greenViewController.tabBarItem.image = .add
    
        tapBarController.setViewControllers([
            UINavigationController(rootViewController: redViewController),
            UINavigationController(rootViewController: blueViewController),
            UINavigationController(rootViewController: greenViewController)
        ], animated: true)
    }
}
