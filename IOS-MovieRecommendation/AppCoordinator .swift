import UIKit

protocol Configurable {
    func configure(with viewController: UIViewController)
}

final class AppCoordinator {
    
//    let tabBarController: UITabBarController = {
//        let view = UITabBarController()
//        view.tabBar.backgroundColor = ColorPalette.customBlack
//
//        return view
//    }()
    
    // MARK: - Properties
    
    private var unauthorizedPage: UnauthorizedPageViewController
    private var authorizedPage: AuthorizedPageViewController
    private var cardViewController: CardViewController
    private var ratedCollectionViewController: RatedCollectionViewController
    private var networkSerivce: NetworkService
    private var appDelegate: AppDelegate
    // MARK: - Lifecycle
    
    init(
        unauthorizedPage: UnauthorizedPageViewController,
        authorizedPage: AuthorizedPageViewController,
        cardViewController: CardViewController,
        ratedCollectionViewController: RatedCollectionViewController,
        networkSerivce: NetworkService,
        appDelegate: AppDelegate
    ) {
        self.unauthorizedPage = unauthorizedPage
        self.authorizedPage = authorizedPage
        self.cardViewController = cardViewController
        self.ratedCollectionViewController = ratedCollectionViewController
        self.networkSerivce = networkSerivce
        self.appDelegate = appDelegate
        
        setupDesign()

//        if isUserLogedIn() {
//            tabBarController.setViewControllers([
//                UINavigationController(rootViewController: cardView),
//                UINavigationController(rootViewController: ratedCollectionView),
//            ], animated: true)
//        } else {
//            tabBarController.setViewControllers([
//                UINavigationController(rootViewController: cardView),
//                UINavigationController(rootViewController: ratedCollectionView),
//            ], animated: true)
//        }
        
    }
    
    public func getStartingPage() {
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        let password = UserDefaults.standard.string(forKey: "password") ?? ""
        let userDTO = UserDTO(login: username, password: password)
        
        networkSerivce.login(credentials: userDTO) { [weak self] response in
            switch response {
            case .success:
                self?.appDelegate.configure(with: self?.authorizedPage ?? UIViewController())
            case .failure:
                self?.appDelegate.configure(with: self?.unauthorizedPage ?? UIViewController())
            }
        }
    }
//
//    public func isUserLogedIn() -> Bool{
//        let username = UserDefaults.standard.string(forKey: "username")
//        let password = UserDefaults.standard.string(forKey: "password")
//
//        return false
//    }
//
//    public func loginSuccess() {
//
//    }
//
//    public func registerSuccess() {
//
//    }
//
//    public func joinToRoom(){
//        let roomId = UserDefaults.standard.string(forKey: "roomId")
//
//        print(roomId!)
//    }
//
//    public func userWaitingRoom(){
//        let roomId = UserDefaults.standard.string(forKey: "roomId")
//        let userName = UserDefaults.standard.string(forKey: "userName")
//
//        print(roomId!, userName!)
//
//    }
//
//    public func roomStarted(on viewController: UIViewController){
//        viewController.navigationController?.pushViewController(tabBarController, animated: true)
//    }
    
    // MARK: - Private
    
    private func setupDesign() {
        setupAuthorizedPageDesign()
        setupUnauthorizedPageDesign()
        setupCardViewControllerDesign()
        setupRatedCollectionViewDesign()
    }
    
    private func setupUnauthorizedPageDesign() {
        unauthorizedPage.tabBarItem.title = "Login"
        unauthorizedPage.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        unauthorizedPage.tabBarItem.image = .add.withTintColor(.systemGray)
    }
    
    private func setupAuthorizedPageDesign() {
        authorizedPage.tabBarItem.title = "Join"
        authorizedPage.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        authorizedPage.tabBarItem.image = .add.withTintColor(.systemGray)
    }
    
    private func setupCardViewControllerDesign() {
        cardViewController.tabBarItem.title = "Movies"
        cardViewController.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        cardViewController.tabBarItem.image = .add.withTintColor(.systemGray)
    }
    
    private func setupRatedCollectionViewDesign() {
        ratedCollectionViewController.tabBarItem.title = "Ratings"
        ratedCollectionViewController.tabBarItem.selectedImage = .add.withTintColor(ColorPalette.customYellow, renderingMode: .alwaysOriginal)
        ratedCollectionViewController.tabBarItem.image = .add.withTintColor(.systemGray)
    }
}


