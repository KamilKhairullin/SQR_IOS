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
        
        
        let ratedCollectionView = RatedCollectionViewController()
        ratedCollectionView.tabBarItem.title = "Liked"
        ratedCollectionView.tabBarItem.image = .add
        
        cardView.moviewCollectionDelegate = ratedCollectionView
    
        tapBarController.setViewControllers([
            UINavigationController(rootViewController: cardView),
            UINavigationController(rootViewController: ratedCollectionView),
//            UINavigationController(rootViewController: blueViewController)
        ], animated: true)
    }
    
}


