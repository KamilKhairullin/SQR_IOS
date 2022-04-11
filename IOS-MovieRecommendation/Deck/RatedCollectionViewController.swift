//
//  LikedCollectionViewController.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 08.04.2022.
//

import Foundation
import UIKit



protocol RatedCollectionDelegate: AnyObject {
    func addMovieToCollection(movie: Movie)
    func getLikedMovieAmount() -> Int
}


class RatedCollectionViewController: UIViewController {
    
    private var movieCollection: [Movie]
    
    
    private var screenTitle: UILabel = {
        let label = UILabel()
        label.text = "Ratings"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = ColorPalette.customWhite
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var mainContainer: UIView = {
        let uv = UIView()
        uv.backgroundColor = .clear
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    private var mainContainerTopFadeMask: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor

        gl.colors = [colorTop, colorBottom]
        gl.locations = [0, 0.05]
        
        return gl
    }()
    
    private var cardsContainerScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    
    private var mainTopFade: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colorTop = ColorPalette.customBlack.cgColor
        let colorMid = ColorPalette.customBlackSemiTransparent.cgColor
        let colorBottom = UIColor.clear.cgColor
        
        gl.type = .axial
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0, 0.1]
        
        return gl
    }()
    
    
    
    
    
// MARK: -- override functions
    init(){
        
        self.movieCollection = [Movie]()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.isTranslucent = true
        
        view.backgroundColor = .systemPurple
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayers()
        setupTitels()
    }
    
    
    
// MARK: -- functions
    
    private func setupViews() {
        
        view.addSubview(mainContainer)
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        mainContainer.addSubview(cardsContainerScrollView)
        NSLayoutConstraint.activate([
            cardsContainerScrollView.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            cardsContainerScrollView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            cardsContainerScrollView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            cardsContainerScrollView.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor)
        ])
        
        
        
        setupCards()
        
        
        
    }
    
    
    private func setupLayers() {
//        mainTopFade.frame = view.bounds
//        view.layer.addSublayer(mainTopFade)
        
        mainContainerTopFadeMask.frame = CGRect(x: 0, y: 0, width: mainContainer.bounds.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
        mainContainer.layer.mask = mainContainerTopFadeMask
        
    }
    
    
    private func setupTitels() {
        view.addSubview(screenTitle)
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -screenTitle.font.pointSize * 1.5),
            screenTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    
    
    private func setupCards() {
        let cardHeight = 95.0
        var prevViewAnchor: UIView = RatedMovieCardView()
        cardsContainerScrollView.addSubview(prevViewAnchor)
        NSLayoutConstraint.activate([
            prevViewAnchor.topAnchor.constraint(equalTo: cardsContainerScrollView.topAnchor, constant: 32),
            prevViewAnchor.leadingAnchor.constraint(equalTo: cardsContainerScrollView.leadingAnchor, constant: 16),
            prevViewAnchor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            prevViewAnchor.heightAnchor.constraint(equalToConstant: cardHeight)
        ])
        
        for _ in 1...10 {
            let exampleCard = RatedMovieCardView()
            cardsContainerScrollView.addSubview(exampleCard)
            NSLayoutConstraint.activate([
                exampleCard.topAnchor.constraint(equalTo: prevViewAnchor.bottomAnchor, constant: 16),
                exampleCard.leadingAnchor.constraint(equalTo: cardsContainerScrollView.leadingAnchor, constant: 16),
                exampleCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                exampleCard.heightAnchor.constraint(equalToConstant: cardHeight)
            ])
            
            prevViewAnchor = exampleCard
        }
        
        prevViewAnchor.backgroundColor = .systemCyan
        NSLayoutConstraint.activate([
            prevViewAnchor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            prevViewAnchor.bottomAnchor.constraint(equalTo: cardsContainerScrollView.bottomAnchor, constant: -16)
        ])
    }
    
}



extension RatedCollectionViewController: RatedCollectionDelegate {
    func addMovieToCollection(movie: Movie) {
        movieCollection.append(movie)
    }
    
    func getLikedMovieAmount() -> Int {
        return movieCollection.count
    }
    
    
}
