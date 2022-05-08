//
//  LoginPageController.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 13.04.2022.
//

import UIKit
 

class LoginRegisterViewController: UIViewController {

    public var appCoordinator: AppCoordinator?
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Logo")
        iv.contentMode = .scaleAspectFill
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = ColorPalette.customYellow
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24)
        btn.setTitleColor(UIColor.black, for: .normal)
       
        btn.layer.cornerRadius = 12.5
        btn.layer.shadowColor = UIColor.systemGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 2.5
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 12.5
        
        btn.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .black
        btn.setTitle("Register", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24)
        btn.setTitleColor(ColorPalette.customWhite, for: .normal)
        
        btn.layer.cornerRadius = 12.5
        btn.layer.borderColor = ColorPalette.customWhite.cgColor
        btn.layer.borderWidth = 2
        
        btn.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
// MARK: -- lifecycle, override
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
// MARK: -- objc
    
    @objc private func loginButtonClicked() {
        let loginPage = LoginViewController()
        var token: String?
        
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        
        networkService.login(credentials: UserDTO(login: "string", password: "string")) { [weak self] response in
            switch response {
            case .success(let requestToken):
                token = requestToken.token
                networkService.createRoom(token: token ?? "") { [weak self] response in
                    switch response {
                    case .success(let roomInfo):
                        print(roomInfo.slug)
                    case .failure(let error):
                        print(error.rawValue)
                    }
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    
        
        loginPage.appCoordinator = appCoordinator
        self.navigationController?.pushViewController(loginPage, animated: true)
        
    }
    
    @objc private func registerButtonClicked() {
        let registerPage = RegisterViewController()
        navigationController?.pushViewController(registerPage, animated: true)
    }
    
// MARK: -- func
    
    private func setupViews() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -128)
        ])
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 192),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupLayers() {
        
    }
    
    private func setupTitles() {
        
    }
    
    
}

