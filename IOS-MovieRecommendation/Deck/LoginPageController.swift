//
//  LoginPageController.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 13.04.2022.
//

import Foundation
import UIKit



class LoginPageController: UIViewController {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Logo")
        iv.contentMode = .scaleAspectFill
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let createButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .black
        btn.setTitle("Name", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24)
        btn.setTitleColor(ColorPalette.customWhite, for: .normal)
        
        btn.layer.cornerRadius = 12.5
        btn.layer.borderColor = ColorPalette.customWhite.cgColor
        btn.layer.borderWidth = 2
        
        btn.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = ColorPalette.customYellow
        btn.setTitle("Next", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24)
        btn.setTitleColor(UIColor.black, for: .normal)
       
        btn.layer.cornerRadius = 12.5
        btn.layer.shadowColor = UIColor.systemGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 2.5
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 12.5
        
        btn.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let qrImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "qr")
        iv.contentMode = .scaleAspectFill
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
// MARK: -- lifecycle, override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = ColorPalette.customYellow
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
// MARK: -- objc
    
    @objc private func loginButtonClicked() {
        print("Name")
    }
    
    @objc private func nextButtonClicked() {
        print("Next")
    }
    
// MARK: -- func
    
    private func setupViews() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -192)
        ])
        
        view.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 96),
            createButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        view.addSubview(qrImageView)
        NSLayoutConstraint.activate([
            qrImageView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 96),
            qrImageView.heightAnchor.constraint(equalToConstant: 96),
            qrImageView.widthAnchor.constraint(equalToConstant: 96),
            qrImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupLayers() {
        
    }
    
    private func setupTitles() {
        
    }
    
    

    
    
    
    
    
}
