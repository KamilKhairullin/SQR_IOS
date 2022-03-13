//
//  CardViewController.swift
//  IOS-MovieRecommendation
//
//  Created by Kamil on 11.03.2022.
//

import UIKit


extension UIColor {
    static var customWhite = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    static var customBlack = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    static var customMiddleWhite = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
    static var customWhiteTransparrent = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
}

struct Movie {
    let title: String
    let imageName: String
    let description: String
    
    let rating: Float
}



class CardViewController: UIViewController {
    
    private let movies = [
        Movie(title: "Yellow Poster", imageName: "2", description: "Some art with yellow as a main color. There is a girl with mask and smoke coming out from the mask. In addition, it has some japanese and futuristic cyber style", rating: 7.4),
        Movie(title: "Blue poster", imageName: "1", description: "Late sunset or almost twilight. Picture is taken in some desert. Beautifull blue sky gives some calming tone. Also, there is a man on quadrocycle", rating: 8.1),
        Movie(title: "Peachy Poster", imageName: "3", description: "Early sunset or golden hour. On the frame, you can see a beach with wonderful ocean waves and a man going to surf", rating: 7.9)
    ]
    
    private var currentPosterIdx = -1
    
    private var initialTouchPoint = CGPoint(x: 0, y: 0)
    
    private var moviePosterContainer: UIView = {
        let viewContainer = UIView()
        
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        return viewContainer
    }()
    
    private var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var posterBottomFade: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colorTop = UIColor.clear.cgColor
        let colorMiddle = UIColor.customMiddleWhite.cgColor
        let colorBottom = UIColor.white.cgColor
        
        gl.type = .axial
        gl.colors = [colorTop, colorMiddle, colorBottom]
        gl.locations = [0.25, 0.75, 1]
        
        return gl
    }()
    
    private var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "Movie Title"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieRating: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieDescription: UILabel = {
        let label = UILabel()
        label.text = "Movie description"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .customBlack
        label.contentMode = .topLeft
        label.numberOfLines = .zero
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var mainTopFade: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colorTop = UIColor.black.cgColor
        let colorBottom = UIColor.clear.cgColor
        
        gl.type = .axial
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.05, 0.15]
        
        return gl
    }()
    
    private var leftWhiteFade: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colorLeft = UIColor.white.cgColor
        let colorRight = UIColor.customWhiteTransparrent.cgColor
        
        gl.type = .axial
        gl.startPoint = CGPoint(x: 0, y: 1)
        gl.endPoint = CGPoint(x: 1, y: 1)
        gl.colors = [colorLeft, colorRight]
        gl.locations = [0, 0]
        
        return gl
    }()
    
    private var rightBlackFade: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colorLeft = UIColor.clear.cgColor
        let colorRight = UIColor.black.cgColor
        
        gl.type = .axial
        gl.startPoint = CGPoint(x: 0, y: 1)
        gl.endPoint = CGPoint(x: 1, y: 1)
        gl.colors = [colorLeft, colorRight]
        gl.locations = [1, 1]
        
        return gl
    }()
    
    
// MARK: - override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        nextPoster()
        setupViews()
        
        moviePosterContainer.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayers()
        setupTitles()
    }
    
    
// MARK: - objc functions
    
    @objc private func nextPoster() {
        currentPosterIdx = (currentPosterIdx + 1) % 3
        
        UIView.transition(
            with: moviePoster,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: { [self] in
                moviePoster.image = UIImage(named: movies[currentPosterIdx].imageName)
            },
            completion: nil
        )
        
        movieTitle.text = movies[currentPosterIdx].title
        movieRating.text = String(movies[currentPosterIdx].rating)
        movieDescription.text = movies[currentPosterIdx].description
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: moviePosterContainer)
        let maxSwipeDistance = view.bounds.width / 2
        let swipeDistance = initialTouchPoint.x - location.x
        let multiplier = min(1, abs(swipeDistance) / maxSwipeDistance)
        
        if gesture.state == .began {
            initialTouchPoint = gesture.location(in: moviePosterContainer)
        } else if gesture.state == .ended {
            if multiplier > 0.5 {
                nextPoster()
            } else if multiplier < -0.5 {
                nextPoster()
            }
            
            rightBlackFade.locations = [1, 1]
            leftWhiteFade.locations = [0, 0]
        } else {
            if swipeDistance > 0 {
                // left : Dislike : BlackFade
                rightBlackFade.locations = [NSNumber(value: 1 - multiplier), 1]
            } else if swipeDistance < 0 {
                // right : Like : WhiteFade
                leftWhiteFade.locations = [0, NSNumber(value: multiplier)]
            }
            
        }
    }
    
    
 // MARK: - functions
    
    private func setupViews() {
        view.addSubview(moviePosterContainer)
        NSLayoutConstraint.activate([
            moviePosterContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -48),
            moviePosterContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            moviePosterContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            moviePosterContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        moviePosterContainer.addSubview(moviePoster)
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: moviePosterContainer.topAnchor),
            moviePoster.bottomAnchor.constraint(equalTo: moviePosterContainer.bottomAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: moviePosterContainer.leadingAnchor),
            moviePoster.trailingAnchor.constraint(equalTo: moviePosterContainer.trailingAnchor)
        ])
    }
    
    private func setupLayers() {
        posterBottomFade.frame = moviePosterContainer.bounds
        moviePosterContainer.layer.addSublayer(posterBottomFade)
        
        mainTopFade.frame = view.bounds
        view.layer.addSublayer(mainTopFade)
        
        leftWhiteFade.frame = view.bounds
        view.layer.addSublayer(leftWhiteFade)

        rightBlackFade.frame = view.bounds
        view.layer.addSublayer(rightBlackFade)
        
        let cornerRad = 25.0
        moviePoster.layer.cornerRadius = cornerRad
        moviePoster.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner ]
        
        posterBottomFade.cornerRadius = cornerRad
        moviePosterContainer.layer.cornerRadius = cornerRad
        
    }
    
    private func setupTitles() {
        moviePosterContainer.addSubview(movieTitle)
        NSLayoutConstraint.activate([
            movieTitle.bottomAnchor.constraint(equalTo: moviePosterContainer.bottomAnchor, constant: -128),
            movieTitle.leadingAnchor.constraint(equalTo: moviePosterContainer.leadingAnchor, constant: 16)
        ])
        
        moviePosterContainer.addSubview(movieRating)
        NSLayoutConstraint.activate([
            movieRating.bottomAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieRating.trailingAnchor.constraint(equalTo: moviePosterContainer.trailingAnchor, constant: -16)
        ])
        
        moviePosterContainer.addSubview(movieDescription)
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 32),
            movieDescription.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            movieDescription.trailingAnchor.constraint(equalTo: movieRating.trailingAnchor),
            movieDescription.bottomAnchor.constraint(equalTo: moviePosterContainer.bottomAnchor, constant: -16)
        ])
    }

}

