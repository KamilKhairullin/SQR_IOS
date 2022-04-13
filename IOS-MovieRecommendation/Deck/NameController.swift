//
//  LoginPageController.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 13.04.2022.
//

import Foundation
import UIKit



class NameController: UIViewController {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Logo")
        iv.contentMode = .scaleAspectFill
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameInputField: UITextField = {
        let iv = UITextField()
        iv.backgroundColor = ColorPalette.customWhite
        iv.textColor = ColorPalette.customBlack
        iv.tintColor = .systemPurple
        iv.font = .systemFont(ofSize: 24)
        iv.textAlignment = .center
        
        iv.placeholder = "Your name"
        
        iv.layer.cornerRadius = 12.5
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nextButton: UIButton = {
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
    
    @objc private func nextButtonClicked() {
        guard let text = nameInputField.text else {
            return
        }
        
        print(text)
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
        
        view.addSubview(nameInputField)
        NSLayoutConstraint.activate([
            nameInputField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 96),
            nameInputField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            nameInputField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            nameInputField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameInputField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: nameInputField.bottomAnchor, constant: 16),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    
    private func setupLayers() {
        
    }
    
    private func setupTitles() {
        
    }
    
}
