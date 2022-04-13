//
//  LoginController.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 13.04.2022.
//

import Foundation
import UIKit
 

class Login: UIViewController {
    
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
    
    let createButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .black
        btn.setTitle("Create", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24)
        btn.setTitleColor(ColorPalette.customWhite, for: .normal)
        
        btn.layer.cornerRadius = 12.5
        btn.layer.borderColor = ColorPalette.customWhite.cgColor
        btn.layer.borderWidth = 2
        
        btn.addTarget(self, action: #selector(createButtonClicked), for: .touchUpInside)
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
        print("Login")
        
        let roomPage = RoomIdController()
        self.navigationController?.pushViewController(roomPage, animated: true)
        
    }
    
    @objc private func createButtonClicked() {
        print("Create")
        
        let createRoom = CreateRoomController()
        navigationController?.pushViewController(createRoom, animated: true)
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
        
        view.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            createButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupLayers() {
        
    }
    
    private func setupTitles() {
        
    }
    
    
    
    
}
