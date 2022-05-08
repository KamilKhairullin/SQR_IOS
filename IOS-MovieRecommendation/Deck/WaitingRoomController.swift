//
//  WaitingRoomController.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 07.05.2022.
//

import UIKit


class WaitingRoomController: UIViewController {
    
    public var appCoordinator: AppCoordinator?
    
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
    
    let waitingLablel: UILabel = {
        let l = UILabel()
        l.text = "Waiting for others"
        l.font = .systemFont(ofSize: 24)
        l.textColor = ColorPalette.customWhite
        l.textAlignment = .center
        
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    
// MARK: -- lifecycle, override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupViews()
        
        if let appCoordinator = appCoordinator {
            appCoordinator.userWaitingRoom()
        }
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

    
// MARK: -- func
    
    private func setupViews() {
        
        view.addSubview(qrImageView)
        NSLayoutConstraint.activate([
            qrImageView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 128),
            qrImageView.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 128),
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
        
        view.addSubview(waitingLablel)
        NSLayoutConstraint.activate([
            waitingLablel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -96),
            waitingLablel.leadingAnchor.constraint(equalTo: partyLabel.leadingAnchor),
            waitingLablel.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor),
        ])
    }
    
    private func setupLayers() {
        
    }
    
    private func setupTitles() {
        
    }
    
    
    public func roomStarted() {
            
    }

}