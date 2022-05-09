//
//  CardViewController.swift
//  IOS-MovieRecommendation
//
//  Created by Kamil on 11.03.2022.
//

import UIKit



class CardViewController: UIViewController {
    
    private let network = MockNetworkService(networkClient: nil)
    
    public var moviewCollectionDelegate: RatedCollectionDelegate?
    
    private var screenTitle: UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = ColorPalette.customWhite
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private var currentMovie = Movie(id: "0", title: "Title", posterURL: "URL", description: "Description", rating: 0.0, ratingBorder: 0.0)
    private var currentMovie = MovieDTO(
        id: "id", name: "name", posterUrl: "URL", description: "Description",
        rating: Rating(kinopoisk: 1.1, imdb: 2.2, tmdb: 3.3),
        genres: ["Adventure", "Fantasy", "Comedy"],
        actors: [ActorDTO(name: "Actor 1", photoUrl: "AURL"),
                 ActorDTO(name: "Actor 2", photoUrl: "AURL"),
                 ActorDTO(name: "Actor 3", photoUrl: "AURL")
                ]
    )
    private var currentMovieImage = UIImage(named: "Leon")
    
    private var initialTouchPoint = CGPoint(x: 0, y: 0)
    private var isDescriptionHidden = true
    
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
        let colorTop = ColorPalette.customWhiteTransparrent.cgColor
        let colorMiddle = ColorPalette.customMiddleWhite.cgColor
        let colorBottom = UIColor.white.cgColor
        
        gl.type = .axial
        gl.colors = [colorTop, colorMiddle, colorBottom]
        gl.locations = [0.4, 0.8, 1]
        
        return gl
    }()
    
    private var descriptionContainer: UIView = {
        let myView = UIView()
        myView.backgroundColor = .clear
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private var descriptionScrollableView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private var descriptionTopFadeMask: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colorTop = UIColor.clear.cgColor
//        let colorMiddle = UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor

        gl.colors = [colorTop, colorBottom]
        gl.locations = [0, 0.2]
        
        return gl
    }()
    
    
    private var movieRating: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIFont(name: "Times New Roman", size: 36)
        label.textColor = ColorPalette.customYellow
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "Movie Title"
        label.font = UIFont(name: "Times New Roman", size: 36)
        label.textColor = ColorPalette.customBlack
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieYear: UILabel = {
        let label = UILabel()
        label.text = "2022"
        label.font = UIFont(name: "Times New Roman", size: 24)
        label.textColor = ColorPalette.customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieProducer: UILabel = {
        var label = UILabel()
        label.text = "Producer"
        label.font = UIFont(name: "Times New Roman", size: 22)
        label.textColor = ColorPalette.customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieProducerName: UILabel = {
        var label = UILabel()
        label.text = "Producer Name"
        label.font = UIFont(name: "Times New Roman", size: 22)
        label.textColor = ColorPalette.customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieCountry: UILabel = {
        var label = UILabel()
        label.text = "Country"
        label.font = UIFont(name: "Times New Roman", size: 22)
        label.textColor = ColorPalette.customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieCountryName: UILabel = {
        var label = UILabel()
        label.text = "Country Name"
        label.font = UIFont(name: "Times New Roman", size: 22)
        label.textColor = ColorPalette.customBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieDescription: UILabel = {
        let label = UILabel()
        label.text = "Movie description"
        label.font = UIFont(name: "Times New Roman", size: 17)
        label.textColor = ColorPalette.customBlack
        label.contentMode = .topLeft
        label.numberOfLines = .zero
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var mainTopFade: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colorTop = UIColor.black.cgColor
        let colorBottom = ColorPalette.customBlackTransparent.cgColor
        
        gl.type = .axial
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0, 0.1]
        
        return gl
    }()
    
    private var likeLable: UILabel = {
        let label = UILabel()
        label.text = "LIKE"
        label.font = UIFont.systemFont(ofSize: 64)
        label.textColor = ColorPalette.customBlack
        label.alpha = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dislikeLable: UILabel = {
        let label = UILabel()
        label.text = "DISLIKE"
        label.font = UIFont.systemFont(ofSize: 64)
        label.textColor = ColorPalette.customWhite
        label.alpha = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var leftWhiteFade: CAGradientLayer = {
        let gl = CAGradientLayer()
        let colorLeft = ColorPalette.customWhite.cgColor
        let colorRight = ColorPalette.customWhiteTransparrent.cgColor
        
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
        toggleDescription()
        
        nextPoster()
        setupViews()
        
        moviePosterContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        moviePosterContainer.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
        let scrollViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDescriptionPan))
        scrollViewPanGesture.delegate = self
        descriptionScrollableView.addGestureRecognizer(scrollViewPanGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayers()
        setupTitles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
// MARK: - objc functions
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        toggleDescription()
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: moviePosterContainer)
        
        let maxSwipeXDistance = view.bounds.width * 0.7
        let swipeXDistance = initialTouchPoint.x - location.x
        let multiplierX = min(1, abs(swipeXDistance) / maxSwipeXDistance)
        
        if gesture.state == .began {
            initialTouchPoint = gesture.location(in: moviePosterContainer)
        } else if gesture.state == .ended {
            if  multiplierX > 0.5 && swipeXDistance > 0 {
                movieDisliked()
            } else if multiplierX > 0.5 && swipeXDistance < 0 {
                movieLiked()
            }
            
            resetSwipeFades()
        } else {
            if swipeXDistance > 0 {
                // left : Dislike : BlackFade
                rightBlackFade.locations = [NSNumber(value: 1 - multiplierX), 1]
                dislikeLable.alpha = multiplierX
            } else if swipeXDistance < 0 {
                // right : Like : WhiteFade
                leftWhiteFade.locations = [0, NSNumber(value: multiplierX)]
                likeLable.alpha = multiplierX
            }
        }
    }
    
    @objc private func handleDescriptionPan(gesture: UIPanGestureRecognizer) {
        let maxSwipeYDistance = descriptionContainer.bounds.height
        let swipeYDistance = descriptionScrollableView.contentOffset.y
        let multiplierY = 1 - min(0.9, swipeYDistance / maxSwipeYDistance)
        let fadeCoef = 0.8
        
        posterBottomFade.locations = [0.4, NSNumber( value: min(fadeCoef, max(fadeCoef * multiplierY, 0.6)) ), 1]
    }
    
    
 // MARK: - functions
    
    private func movieLiked() {
        guard let moviewCollectionDelegate = moviewCollectionDelegate else {
            return
        }
        
        moviewCollectionDelegate.addMovieToCollection(movie: currentMovie, image: currentMovieImage!)
        
        nextPoster()
    }
    
    private func movieDisliked() {
        nextPoster()
    }
    
    private func nextPoster() {
        
        
//        network.getNextRecommendation(for: 1) { [weak self] result in
//            guard let self = self else {
//                return
//            }
//            switch result {
//            case .success(let movie):
//                self.currentMovie = movie
//                UIView.transition(
//                    with: self.moviePoster,
//                    duration: 0.5,
//                    options: .transitionCrossDissolve,
//                    animations: { [self] in
//                        let url = URL(string: movie.posterURL ?? "") ?? URL(fileURLWithPath: "1")
//                        self.downloadImage(from: url)
//                    },
//                    completion: nil
//                )
//
//                self.movieTitle.text = movie.title
//                self.movieRating.text = String(movie.rating ?? 0.0)
//                self.movieDescription.text = movie.description
//
//                self.descriptionScrollableView.contentOffset = CGPoint.zero
//                self.posterBottomFade.locations = [0.4, 0.8, 1]
//            case .failure:
//                break
//            }
//        }
    }
    
    private func resetSwipeFades() {
        rightBlackFade.locations = [1, 1]
        leftWhiteFade.locations = [0, 0]
        likeLable.alpha = 0
        dislikeLable.alpha = 0
    }
    
    private func setupViews() {
        view.addSubview(moviePosterContainer)
        NSLayoutConstraint.activate([
            moviePosterContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
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
        
        moviePosterContainer.layer.addSublayer(posterBottomFade)
        
        moviePosterContainer.addSubview(descriptionContainer)
        NSLayoutConstraint.activate([
            descriptionContainer.topAnchor.constraint(equalTo: moviePosterContainer.bottomAnchor, constant: -300),
            descriptionContainer.leadingAnchor.constraint(equalTo: moviePosterContainer.leadingAnchor, constant: 0),
            descriptionContainer.trailingAnchor.constraint(equalTo: moviePosterContainer.trailingAnchor, constant: 0),
            descriptionContainer.bottomAnchor.constraint(equalTo: moviePosterContainer.bottomAnchor, constant: 0)
        ])
        
        descriptionContainer.addSubview(descriptionScrollableView)
        NSLayoutConstraint.activate([
            descriptionScrollableView.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 0),
            descriptionScrollableView.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor, constant: 0),
            descriptionScrollableView.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: 0),
            descriptionScrollableView.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: 0),
        ])
    }
    
    private func setupLayers() {
        leftWhiteFade.frame = view.bounds
        view.layer.addSublayer(leftWhiteFade)

        rightBlackFade.frame = view.bounds
        view.layer.addSublayer(rightBlackFade)
        
        posterBottomFade.frame = moviePosterContainer.bounds
        
        mainTopFade.frame = moviePosterContainer.bounds
        moviePosterContainer.layer.addSublayer(mainTopFade)
        
        let cornerRad = 25.0
        moviePoster.layer.cornerRadius = cornerRad
        moviePoster.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner ]
        
        posterBottomFade.cornerRadius = cornerRad
        moviePosterContainer.layer.cornerRadius = cornerRad
        
//        descriptionTopFadeMask.frame = descriptionContainer.bounds
        descriptionTopFadeMask.frame = CGRect(x: 0, y: 0, width: moviePosterContainer.bounds.width, height: 300)
        descriptionContainer.layer.mask = descriptionTopFadeMask
    }
    
    private func setupTitles() {
        moviePosterContainer.addSubview(screenTitle)
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: moviePosterContainer.topAnchor, constant: -screenTitle.font.pointSize * 1.5),
            screenTitle.centerXAnchor.constraint(equalTo: moviePosterContainer.centerXAnchor)
        ])
        
        moviePosterContainer.addSubview(movieRating)
        NSLayoutConstraint.activate([
            movieRating.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            movieRating.leadingAnchor.constraint(equalTo: moviePosterContainer.leadingAnchor, constant: 16)
        ])
        
        descriptionScrollableView.addSubview(movieTitle)
        descriptionScrollableView.addSubview(movieYear)
        descriptionScrollableView.addSubview(movieProducer)
        descriptionScrollableView.addSubview(movieCountry)
        descriptionScrollableView.addSubview(movieProducerName)
        descriptionScrollableView.addSubview(movieCountryName)
        descriptionScrollableView.addSubview(movieDescription)
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: descriptionScrollableView.topAnchor, constant: 150),
            movieTitle.leadingAnchor.constraint(equalTo: descriptionScrollableView.leadingAnchor, constant: 16),
            movieTitle.widthAnchor.constraint(equalToConstant: 285),
            
            movieYear.bottomAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieYear.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -16),
            
            movieProducer.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 32),
            movieProducer.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor, constant: 0),
            
            movieCountry.topAnchor.constraint(equalTo: movieProducer.bottomAnchor, constant: 8),
            movieCountry.leadingAnchor.constraint(equalTo: movieProducer.leadingAnchor, constant: 0),
            
            movieProducerName.topAnchor.constraint(equalTo: movieYear.bottomAnchor, constant: 32),
            movieProducerName.trailingAnchor.constraint(equalTo: movieYear.trailingAnchor, constant: 0),
            
            movieCountryName.topAnchor.constraint(equalTo: movieProducerName.bottomAnchor, constant: 8),
            movieCountryName.trailingAnchor.constraint(equalTo: movieProducerName.trailingAnchor, constant: 0),
            
            movieDescription.topAnchor.constraint(equalTo: movieCountry.bottomAnchor, constant: 32),
            movieDescription.leadingAnchor.constraint(equalTo: descriptionScrollableView.leadingAnchor, constant: 16),
            movieDescription.trailingAnchor.constraint(equalTo: moviePosterContainer.trailingAnchor, constant: -16),
            movieDescription.bottomAnchor.constraint(equalTo: descriptionScrollableView.bottomAnchor, constant: -16),
        ])

        view.addSubview(likeLable)
        NSLayoutConstraint.activate([
            likeLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeLable.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        view.addSubview(dislikeLable)
        NSLayoutConstraint.activate([
            dislikeLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dislikeLable.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func toggleDescription() {
        isDescriptionHidden.toggle()
        
        posterBottomFade.isHidden = isDescriptionHidden
        descriptionContainer.isHidden = isDescriptionHidden
        descriptionScrollableView.isHidden = isDescriptionHidden
        
        movieTitle.isHidden = isDescriptionHidden
        movieYear.isHidden = isDescriptionHidden
        movieProducer.isHidden = isDescriptionHidden
        movieProducerName.isHidden = isDescriptionHidden
        movieCountry.isHidden = isDescriptionHidden
        movieCountryName.isHidden = isDescriptionHidden
        movieRating.isHidden = isDescriptionHidden
        
        movieDescription.isHidden = isDescriptionHidden
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil, self == self else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.moviePoster.image = UIImage(data: data)
            }
            self.currentMovieImage = UIImage(data: data)
        }
    }
}

extension CardViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
