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
    static var customBlackSemiTransparent = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    static var customMiddleWhite = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
    static var customWhiteTransparrent = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
    static var customYellow = UIColor(red: 0.96, green: 0.98, blue: 0.098, alpha: 1)
}


class CardViewController: UIViewController {
    
    
    private var screenTitle: UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .customWhite
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    private let movies = [
        Movie(imageURL: "1", title: "Blue Desert", year: 2019, producer: "Bekzhan Talgat", country: "Kazakhstan", ratingIMDB: 8.9, duration: 128, genre: ["Cool", "Calm"], description: "Late sunset or almost twilight. Picture is taken in some desert. Beautifull blue sky gives some calming tone. Also, there is a man on quadrocycle"),
        Movie(imageURL: "2", title: "Cyber Girl", year: 2077, producer: "Alice Totti", country: "Liberty City", ratingIMDB: 9.1, duration: 153, genre: ["Epic", "Juicy"], description: "Some art with yellow as a main color. There is a girl with mask and smoke coming out from the mask. In addition, it has some japanese and futuristic cyber style"),
        Movie(imageURL: "3", title: "Peachy Beach", year: 2007, producer: "Bauyrzhan Saduakassov", country: "California", ratingIMDB: 9.0, duration: 137, genre: ["Nastolgia", "Wonderful"], description: "Early sunset or golden hour. On the frame, you can see a beach with wonderful ocean waves and a man going to surf"),
    ]
    
    private var currentPosterIdx = -1
    private var initialTouchPoint = CGPoint(x: 0, y: 0)
    private var isDescriptionHidden = false
    
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
    
    private var movieRating: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIFont(name: "Times New Roman", size: 36)
        label.textColor = .customYellow
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "Movie Title"
        label.font = UIFont(name: "Times New Roman", size: 36)
        label.textColor = .customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieYear: UILabel = {
        let label = UILabel()
        label.text = "2022"
        label.font = UIFont(name: "Times New Roman", size: 24)
        label.textColor = .customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieProducer: UILabel = {
        var label = UILabel()
        label.text = "Producer"
        label.font = UIFont(name: "Times New Roman", size: 22)
        label.textColor = .customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieProducerName: UILabel = {
        var label = UILabel()
        label.text = "Producer Name"
        label.font = UIFont(name: "Times New Roman", size: 22)
        label.textColor = .customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieCountry: UILabel = {
        var label = UILabel()
        label.text = "Country"
        label.font = UIFont(name: "Times New Roman", size: 22)
        label.textColor = .customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieCountryName: UILabel = {
        var label = UILabel()
        label.text = "Country Name"
        label.font = UIFont(name: "Times New Roman", size: 22)
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
        let colorMid = UIColor.customBlackSemiTransparent.cgColor
        let colorBottom = UIColor.clear.cgColor
        
        gl.type = .axial
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0, 0.1]
        
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
        
//        print(UIFont.familyNames)
        view.backgroundColor = .black
        toggleDescription()
        
        nextPoster()
        setupViews()
        
        moviePosterContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
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
                moviePoster.image = UIImage(named: movies[currentPosterIdx].imageURL)
            },
            completion: nil
        )
        
        movieTitle.text = movies[currentPosterIdx].title
        movieYear.text = String(movies[currentPosterIdx].year)
        movieProducerName.text = movies[currentPosterIdx].producer
        movieCountryName.text = movies[currentPosterIdx].country
        movieRating.text = String(movies[currentPosterIdx].ratingIMDB)
        
        movieDescription.text = movies[currentPosterIdx].description
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        toggleDescription()
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
            moviePosterContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
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
        leftWhiteFade.frame = view.bounds
        view.layer.addSublayer(leftWhiteFade)

        rightBlackFade.frame = view.bounds
        view.layer.addSublayer(rightBlackFade)
        
        
        posterBottomFade.frame = moviePosterContainer.bounds
        moviePosterContainer.layer.addSublayer(posterBottomFade)
        
        mainTopFade.frame = moviePosterContainer.bounds
        moviePosterContainer.layer.addSublayer(mainTopFade)
        
        let cornerRad = 25.0
        moviePoster.layer.cornerRadius = cornerRad
        moviePoster.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner ]
        
        posterBottomFade.cornerRadius = cornerRad
        moviePosterContainer.layer.cornerRadius = cornerRad
    }
    
    private func setupTitles() {
        moviePosterContainer.addSubview(screenTitle)
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: moviePosterContainer.topAnchor, constant: -screenTitle.font.pointSize * 1.5),
            screenTitle.centerXAnchor.constraint(equalTo: moviePosterContainer.centerXAnchor)
        ])
        
        moviePosterContainer.addSubview(movieTitle)
        NSLayoutConstraint.activate([
            movieTitle.bottomAnchor.constraint(equalTo: moviePosterContainer.bottomAnchor, constant: -128),
            movieTitle.leadingAnchor.constraint(equalTo: moviePosterContainer.leadingAnchor, constant: 16)
        ])
        
        moviePosterContainer.addSubview(movieRating)
        NSLayoutConstraint.activate([
            movieRating.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            movieRating.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor)
        ])
        
        moviePosterContainer.addSubview(movieYear)
        NSLayoutConstraint.activate([
            movieYear.bottomAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieYear.trailingAnchor.constraint(equalTo: moviePosterContainer.trailingAnchor, constant: -16)
        ])
        
        moviePosterContainer.addSubview(movieProducer)
        NSLayoutConstraint.activate([
            movieProducer.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 32),
            movieProducer.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor, constant: 0)
        ])
        
        moviePosterContainer.addSubview(movieCountry)
        NSLayoutConstraint.activate([
            movieCountry.topAnchor.constraint(equalTo: movieProducer.bottomAnchor, constant: 8),
            movieCountry.leadingAnchor.constraint(equalTo: movieProducer.leadingAnchor, constant: 0)
        ])
        
        moviePosterContainer.addSubview(movieProducerName)
        NSLayoutConstraint.activate([
            movieProducerName.topAnchor.constraint(equalTo: movieYear.bottomAnchor, constant: 32),
            movieProducerName.trailingAnchor.constraint(equalTo: movieYear.trailingAnchor, constant: 0)
        ])
        
        moviePosterContainer.addSubview(movieCountryName)
        NSLayoutConstraint.activate([
            movieCountryName.topAnchor.constraint(equalTo: movieProducerName.bottomAnchor, constant: 8),
            movieCountryName.trailingAnchor.constraint(equalTo: movieProducerName.trailingAnchor, constant: 0)
        ])
        
//        moviePosterContainer.addSubview(movieDescription)
//        NSLayoutConstraint.activate([
//            movieDescription.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 32),
//            movieDescription.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
//            movieDescription.trailingAnchor.constraint(equalTo: moviePosterContainer.trailingAnchor, constant: -16),
//            movieDescription.bottomAnchor.constraint(equalTo: moviePosterContainer.bottomAnchor, constant: -16)
//        ])
    }
    
    private func toggleDescription() {
        isDescriptionHidden.toggle()
        
        posterBottomFade.isHidden = isDescriptionHidden
        
        movieTitle.isHidden = isDescriptionHidden
        movieYear.isHidden = isDescriptionHidden
        movieProducer.isHidden = isDescriptionHidden
        movieProducerName.isHidden = isDescriptionHidden
        movieCountry.isHidden = isDescriptionHidden
        movieCountryName.isHidden = isDescriptionHidden
        movieRating.isHidden = isDescriptionHidden
        
//        movieDescription.text = movies[currentPosterIdx].description
    }

}

