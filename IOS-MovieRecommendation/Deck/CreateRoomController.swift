//
//  CreateRoomController.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 13.04.2022.
//

import Foundation
import UIKit


class CreateRoomController: UIViewController {
    
    let idLabel: UILabel = {
        let l = UILabel()
        l.text = "ID:"
        l.font = .systemFont(ofSize: 56)
        l.textColor = ColorPalette.customYellow
        
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let roomIdLabel: UILabel = {
        let l = UILabel()
        l.text = "AB1C23"
        l.font = .systemFont(ofSize: 56)
        l.textColor = ColorPalette.customWhite
        
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let qrImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "qr")
        iv.contentMode = .scaleAspectFill
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let partyLabel: UILabel = {
        let l = UILabel()
        l.text = "Party:"
        l.font = .systemFont(ofSize: 36)
        l.textColor = ColorPalette.customYellow
        
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let amountLabel: UILabel = {
        let l = UILabel()
        l.text = "12"
        l.font = .systemFont(ofSize: 36)
        l.textColor = ColorPalette.customWhite
        
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let startButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = ColorPalette.customYellow
        btn.setTitle("Start", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24)
        btn.setTitleColor(UIColor.black, for: .normal)
       
        btn.layer.cornerRadius = 12.5
        btn.layer.shadowColor = UIColor.systemGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 2.5
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 12.5
        
        btn.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    
// MARK: -- lifecycle, override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupViews()
        
        createARoom()
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
    
    @objc private func startButtonClicked() {
        print("Start")
    }
    
// MARK: -- func
    
    private func setupViews() {
        
        view.addSubview(qrImageView)
        NSLayoutConstraint.activate([
            qrImageView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 32),
            qrImageView.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 32),
            qrImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.safeAreaLayoutGuide.layoutFrame.width - 32)/8)
        ])
        
        view.addSubview(idLabel)
        view.addSubview(roomIdLabel)
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 56),
            idLabel.bottomAnchor.constraint(equalTo: qrImageView.topAnchor, constant: -24),
            
            roomIdLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -56),
            roomIdLabel.bottomAnchor.constraint(equalTo: idLabel.bottomAnchor)
        ])
        
        view.addSubview(partyLabel)
        view.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            partyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 56),
            partyLabel.topAnchor.constraint(equalTo: qrImageView.bottomAnchor, constant: 24),
            
            amountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -56),
            amountLabel.topAnchor.constraint(equalTo: partyLabel.topAnchor)
        ])
        
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: partyLabel.bottomAnchor, constant: 64),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    
    private func setupLayers() {
        
    }
    
    private func setupTitles() {
        
    }
    
    
    public func createARoom() {
        
    }
    
    

}
