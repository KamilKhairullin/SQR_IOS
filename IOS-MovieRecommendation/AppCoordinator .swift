import UIKit

final class AppCoordinator {
    
    let tapBarController: UITabBarController = {
        let view = UITabBarController()
        view.tabBar.backgroundColor = ColorPalette.tabBarBackground
        return view
    }()

    init() {
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = .systemRed
        redViewController.tabBarItem.title = "Red"
        redViewController.tabBarItem.image = .add
        
        let maskedView = UIView(frame: CGRect(x: 50, y: 50, width: 256, height: 256))
        maskedView.backgroundColor = ColorPalette.customYellow
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = maskedView.bounds
        gradientMaskLayer.colors = [UIColor.clear.cgColor, ColorPalette.customBlack.cgColor]
        gradientMaskLayer.locations = [0, 1]
        maskedView.layer.mask = gradientMaskLayer
        redViewController.view.addSubview(maskedView)
        
        
        
        
        
        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = .systemBlue
        blueViewController.tabBarItem.title = "Blue"
        blueViewController.tabBarItem.image = .add
        
        let scrollView: UIScrollView = {
            let v = UIScrollView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .cyan
            return v
        }()
        let labelOne: UILabel = {
            let label = UILabel()
            label.text = "Scroll Top"
            label.backgroundColor = .red
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let labelTwo: UILabel = {
            let label = UILabel()
            label.text = "Scroll Bottom"
            label.backgroundColor = .green
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        blueViewController.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: blueViewController.view.safeAreaLayoutGuide.leftAnchor, constant: 8.0),
            scrollView.topAnchor.constraint(equalTo: blueViewController.view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            scrollView.rightAnchor.constraint(equalTo: blueViewController.view.safeAreaLayoutGuide.rightAnchor, constant: -8.0),
            scrollView.bottomAnchor.constraint(equalTo: blueViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
        ])
        
        scrollView.addSubview(labelOne)
        labelOne.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
        labelOne.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0).isActive = true

        scrollView.addSubview(labelTwo)
        labelTwo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        labelTwo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true
        labelTwo.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16.0).isActive = true
        labelTwo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true

        
        
        
        
    
        let greenViewController = CardViewController()
        greenViewController.tabBarItem.title = "Green"
        greenViewController.tabBarItem.image = .add
    
        tapBarController.setViewControllers([
            UINavigationController(rootViewController: redViewController),
            UINavigationController(rootViewController: blueViewController),
            UINavigationController(rootViewController: greenViewController)
        ], animated: true)
    }
    
}
