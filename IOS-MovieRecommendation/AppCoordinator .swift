import UIKit



final class AppCoordinator {
    
    let tapBarController: UITabBarController = {
        let view = UITabBarController()
        view.tabBar.backgroundColor = ColorPalette.customBlack
        return view
    }()

    init() {
        
        
        let cardView = CardViewController()
        cardView.tabBarItem.title = "Cards"
        cardView.tabBarItem.image = .add
        
        
        let likedCollectionView = LikedCollectionViewController()
        likedCollectionView.tabBarItem.title = "Liked"
        likedCollectionView.tabBarItem.image = .add
        
        cardView.moviewCollectionDelegate = likedCollectionView
    
        tapBarController.setViewControllers([
            UINavigationController(rootViewController: cardView),
            UINavigationController(rootViewController: likedCollectionView),
//            UINavigationController(rootViewController: blueViewController)
        ], animated: true)
    }
    
}


