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

    }
    
    public func getStartingPage() {
//        appDelegate.configure(with: unauthorizedPage)
        
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        let password = UserDefaults.standard.string(forKey: "password") ?? ""
        let userDTO = UserDTO(login: username, password: password)

        networkSerivce.login(credentials: userDTO) { [weak self] response in
            switch response {
            case .success(let data):
                UserDefaults.standard.set(data.token, forKey: "token")
                self?.appDelegate.configure(with: self?.authorizedPage ?? UIViewController())
            case .failure:
                self?.appDelegate.configure(with: self?.unauthorizedPage ?? UIViewController())
            }
        }
    }
    
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




extension AppCoordinator: LoginSucceed {
    func loginSucceed(on viewController: UIViewController, with token: String) {
        UserDefaults.standard.set(token, forKey: "token")
        viewController.navigationController?.pushViewController(self.authorizedPage, animated: true)
    }
}

extension AppCoordinator: RegisterSucceed {
    func registerSucceed(on viewController: UIViewController, with token: String) {
        UserDefaults.standard.set(token, forKey: "token")
        viewController.navigationController?.pushViewController(self.authorizedPage, animated: true)
    }
}

extension AppCoordinator: StartTheRoom {
    func startTheRoom(on viewController: UIViewController) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let slug = UserDefaults.standard.string(forKey: "roomSlug") ?? ""
        
        networkSerivce.startRoom(token: token, slug: slug) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
                case .success:
                    let tabBar = UITabBarController()
                    tabBar.setViewControllers([
                        self.cardViewController,
                        self.ratedCollectionViewController
                    ], animated: true)
                    
                    viewController.navigationController?.pushViewController(tabBar, animated: true)
                case .failure(let error):
                    print(error.rawValue)
            }
        }
    }
}

extension AppCoordinator: JoinToTheRoom {
    func JoinToTheRoom(on viewController: UIViewController, roomId: String, failedToJoin: @escaping () -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let slug = UserDefaults.standard.string(forKey: "roomSlug") ?? ""
        
        networkSerivce.join(token: token, slug: slug) { [weak self] response in
            switch response {
            case .success(let roomDTO):
                UserDefaults.standard.set(roomDTO.id, forKey: "roomId")
                let waitingRoom = WaitingRoomController()
                waitingRoom.appCoordinator = self
                
                viewController.navigationController?.pushViewController(waitingRoom, animated: true)
            case .failure(let error):
                failedToJoin()
                print(error.rawValue)
            }
        }
    }
}

extension AppCoordinator: WaitingForOthers {
    func waitingForOthers(on viewController: UIViewController) {
        // network Service
        
        
        let tabBar = UITabBarController()
        tabBar.setViewControllers([
            self.cardViewController,
            self.ratedCollectionViewController
        ], animated: true)
        
        viewController.navigationController?.pushViewController(tabBar, animated: true)
    }
}
