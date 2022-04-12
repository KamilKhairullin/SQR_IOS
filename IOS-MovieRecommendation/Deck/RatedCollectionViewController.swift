//
//  LikedCollectionViewController.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 08.04.2022.
//

import Foundation
import UIKit



protocol RatedCollectionDelegate: AnyObject {
    func addMovieToCollection(movie: Movie, image: UIImage)
    func getLikedMovieAmount() -> Int
}


class RatedCollectionViewController: UIViewController {
    
    private var movieCollection: [MovieCard]
    
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
        let colorTop = ColorPalette.customBlackTransparent.cgColor
        let colorBottom = UIColor.black.cgColor

        gl.colors = [colorTop, colorBottom]
        gl.locations = [0, 0.05]
        
        return gl
    }()
    
    private var cardsContainerScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = ColorPalette.customBlackTransparent
        
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
        self.movieCollection = [MovieCard]()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCards()
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
    
    private func setupCards() {
        if movieCollection.isEmpty { return }
        cardsContainerScrollView.subviews.forEach({ $0.removeFromSuperview() })
        
        var prevTmp = UIView()
        for i in 0..<movieCollection.count {
            let tmp = UIView()
            tmp.translatesAutoresizingMaskIntoConstraints = false
            tmp.backgroundColor = .systemCyan
            tmp.layer.cornerRadius = 25.0
            
            cardsContainerScrollView.addSubview(tmp)
            NSLayoutConstraint.activate([
                tmp.leadingAnchor.constraint(equalTo: cardsContainerScrollView.leadingAnchor, constant: 16),
                tmp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                tmp.heightAnchor.constraint(equalToConstant: 95)
            ])

            if i == 0 {
                NSLayoutConstraint.activate([
                    tmp.topAnchor.constraint(equalTo: cardsContainerScrollView.topAnchor, constant: 32),
                ])
            } else {
                NSLayoutConstraint.activate([
                    tmp.topAnchor.constraint(equalTo: prevTmp.bottomAnchor, constant: 16),
                ])
                if i == movieCollection.count - 1 {
                    NSLayoutConstraint.activate([
                        tmp.bottomAnchor.constraint(equalTo: cardsContainerScrollView.bottomAnchor, constant: -16)
                    ])
                }
            }
            prevTmp = tmp
            
            let mp: UIImageView = {
                let mp = UIImageView()
                mp.contentMode = .scaleAspectFill
                mp.clipsToBounds = true
                mp.layer.cornerRadius = 25.0
                mp.image = movieCollection[i].image
                mp.translatesAutoresizingMaskIntoConstraints = false
                return mp
            }()
            
            tmp.addSubview(mp)
            NSLayoutConstraint.activate([
                mp.topAnchor.constraint(equalTo: tmp.topAnchor),
                mp.leadingAnchor.constraint(equalTo: tmp.leadingAnchor),
                mp.trailingAnchor.constraint(equalTo: tmp.trailingAnchor),
                mp.bottomAnchor.constraint(equalTo: tmp.bottomAnchor)
            ])
        }
        
    }
    
    private func setupLayers() {
        mainContainerTopFadeMask.frame = CGRect(x: 0, y: 0, width: mainContainer.bounds.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
        mainContainer.layer.mask = mainContainerTopFadeMask
        
        for sv in cardsContainerScrollView.subviews {
            let gl: CAGradientLayer = {
                let gl = CAGradientLayer()
                let colorTop = ColorPalette.ratedFadeTop.cgColor
                let colorMid = ColorPalette.ratedFadeMid.cgColor
                let colorBottom = ColorPalette.ratedFadeBottom.cgColor
                gl.cornerRadius = 25.0
                
                gl.type = .axial
                gl.colors = [colorTop, colorMid, colorBottom]
                gl.locations = [0, 0.75, 1]
                
                return gl
            }()
            
            gl.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width - 32, height: 95)
            sv.layer.addSublayer(gl)
        }
    }
    
    private func setupTitels() {
        view.addSubview(screenTitle)
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -screenTitle.font.pointSize * 1.5),
            screenTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        var i = 0
        for sv in cardsContainerScrollView.subviews {
            if i == movieCollection.count { break }
            
            let mt: UILabel = {
                let mt = UILabel()
                mt.text = "Title"
                mt.font = UIFont(name: "Times New Roman", size: 36)
                mt.textColor = ColorPalette.customBlack
                
                mt.translatesAutoresizingMaskIntoConstraints = false
                return mt
            }()
            
            let r: UILabel = {
                let r = UILabel()
                r.text = "0.0"
                r.font = UIFont(name: "Times New Roman", size: 36)
                r.textColor = ColorPalette.customYellow
                
                r.translatesAutoresizingMaskIntoConstraints = false
                return r
            }()
            
            sv.addSubview(mt)
            sv.addSubview(r)
            NSLayoutConstraint.activate([
                mt.leadingAnchor.constraint(equalTo: sv.leadingAnchor, constant: 16),
                mt.bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: -8),
                r.topAnchor.constraint(equalTo: sv.topAnchor, constant: 8),
                r.trailingAnchor.constraint(equalTo: sv.trailingAnchor, constant: -16)
            ])
            
            if !movieCollection.isEmpty {
                mt.text = movieCollection[i].movie.title
                r.text = String(movieCollection[i].movie.rating!)
            }
            
            i += 1
        }
    }
    
}



extension RatedCollectionViewController: RatedCollectionDelegate {
    func addMovieToCollection(movie: Movie, image: UIImage) {
        movieCollection.append(MovieCard(movie: movie, image: image))
        
//        DispatchQueue.global().async {
//            self.movieCollection.sort { $0.movie.rating! > $1.movie.rating! }
//        }
        
    }
    
    func getLikedMovieAmount() -> Int {
        return movieCollection.count
    }
    
    
}
