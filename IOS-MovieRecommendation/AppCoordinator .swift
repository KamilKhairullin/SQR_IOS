import UIKit



final class AppCoordinator {
    
    let tapBarController: UITabBarController = {
        let view = UITabBarController()
        view.tabBar.backgroundColor = ColorPalette.customBlack
        
        return view
    }()

    init() {
        
        
        let cardView = CardViewController()
        cardView.tabBarItem.title = "Movies"
        cardView.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        cardView.tabBarItem.image = .add.withTintColor(.systemGray)
        
        let ratedCollectionView = RatedCollectionViewController()
        ratedCollectionView.tabBarItem.title = "Ratings"
        ratedCollectionView.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        ratedCollectionView.tabBarItem.image = .add.withTintColor(.systemGray)
        
        cardView.moviewCollectionDelegate = ratedCollectionView
        
        tapBarController.setViewControllers([
            UINavigationController(rootViewController: cardView),
            UINavigationController(rootViewController: ratedCollectionView),
        ], animated: true)
    }
    
}


