import UIKit



final class AppCoordinator {
    
    let tabBarController: UITabBarController = {
        let view = UITabBarController()
        view.tabBar.backgroundColor = ColorPalette.customBlack
        
        return view
    }()
    
    
    
    let loginRegisterPage: LoginRegisterViewController
    let joinCreatePage: JoinCreateViewController
    
    init() {
        loginRegisterPage = LoginRegisterViewController()
        joinCreatePage = JoinCreateViewController()
        
        loginRegisterPage.tabBarItem.title = "Login"
        loginRegisterPage.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        loginRegisterPage.tabBarItem.image = .add.withTintColor(.systemGray)
        joinCreatePage.tabBarItem.title = "Join"
        joinCreatePage.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        joinCreatePage.tabBarItem.image = .add.withTintColor(.systemGray)
        
        loginRegisterPage.appCoordinator = self
        joinCreatePage.appCoordinator = self
        
        
        let cardView = CardViewController()
        cardView.tabBarItem.title = "Movies"
        cardView.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        cardView.tabBarItem.image = .add.withTintColor(.systemGray)
        
        let ratedCollectionView = RatedCollectionViewController()
        ratedCollectionView.tabBarItem.title = "Ratings"
        ratedCollectionView.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        ratedCollectionView.tabBarItem.image = .add.withTintColor(.systemGray)
        
        cardView.moviewCollectionDelegate = ratedCollectionView
        
        if isUserLogedIn() {
            tabBarController.setViewControllers([
                UINavigationController(rootViewController: cardView),
                UINavigationController(rootViewController: ratedCollectionView),
            ], animated: true)
        } else {
            tabBarController.setViewControllers([
                UINavigationController(rootViewController: cardView),
                UINavigationController(rootViewController: ratedCollectionView),
            ], animated: true)
        }
        
    }
    
    
    
    public func isUserLogedIn() -> Bool{
        let username = UserDefaults.standard.string(forKey: "username")
        let password = UserDefaults.standard.string(forKey: "password")
        
        return false
    }
    
    public func loginSuccess() {
        
    }
    
    public func registerSuccess() {
        
    }
    
    public func joinToRoom(){
        let roomId = UserDefaults.standard.string(forKey: "roomId")
        
        print(roomId!)
    }
    
    public func userWaitingRoom(){
        let roomId = UserDefaults.standard.string(forKey: "roomId")
        let userName = UserDefaults.standard.string(forKey: "userName")
        
        print(roomId!, userName!)
        
    }
    
    public func roomStarted(on viewController: UIViewController){
        viewController.navigationController?.pushViewController(tabBarController, animated: true)
    }
    
}


