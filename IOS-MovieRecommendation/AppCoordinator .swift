import UIKit



final class AppCoordinator {
    
    let tabBarController: UITabBarController = {
        let view = UITabBarController()
        view.tabBar.backgroundColor = ColorPalette.customBlack
        
        return view
    }()

    let loginView = LoginViewController()
    init() {
        loginView.tabBarItem.title = "Login"
        loginView.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        loginView.tabBarItem.image = .add.withTintColor(.systemGray)
        
        let cardView = CardViewController()
        cardView.tabBarItem.title = "Movies"
        cardView.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        cardView.tabBarItem.image = .add.withTintColor(.systemGray)
        
        let ratedCollectionView = RatedCollectionViewController()
        ratedCollectionView.tabBarItem.title = "Ratings"
        ratedCollectionView.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        ratedCollectionView.tabBarItem.image = .add.withTintColor(.systemGray)
        
        cardView.moviewCollectionDelegate = ratedCollectionView
        
        tabBarController.setViewControllers([
            UINavigationController(rootViewController: loginView),
            UINavigationController(rootViewController: cardView),
            UINavigationController(rootViewController: ratedCollectionView),
        ], animated: true)
    }
    
}


