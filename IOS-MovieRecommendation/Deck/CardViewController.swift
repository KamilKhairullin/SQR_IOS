//
//  CardViewController.swift
//  IOS-MovieRecommendation
//
//  Created by Kamil on 11.03.2022.
//

import UIKit

// swiftlint:disable file_length type_body_length

final class CardViewController: UIViewController {

    public weak var moviewCollectionDelegate: RatedCollectionDelegate?
    var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var screenTitle: UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = ColorPalette.customWhite

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        label.font = UIFont(name: "Times New Roman", size: 24)
        label.textColor = ColorPalette.customBlack
        // label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byTruncatingTail

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var movieYear: UILabel = {
        let label = UILabel()
        label.text = "2022"
        label.font = UIFont(name: "Times New Roman", size: 24)
        label.textColor = ColorPalette.customBlack
        label.textAlignment = .right

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

        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let slug = UserDefaults.standard.string(forKey: "roomSlug") ?? ""
        let movieId = currentMovie.id

        networkService.like(token: token, slug: slug, movieId: movieId) { [weak self] response in
            guard let self = self else { return }

            switch response {
                case .success:
                    moviewCollectionDelegate.addMovieToCollection(movie: self.currentMovie, image: self.currentMovieImage!)
                    self.nextPoster()
                case .failure(let error):
                    print(error.rawValue)
            }
        }
    }

    private func movieDisliked() {
        nextPoster()
    }

    private func nextPoster() {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let slug = UserDefaults.standard.string(forKey: "roomSlug") ?? ""

        networkService.recommend(token: token, slug: slug) { [weak self] response in
            guard let self = self else { return }

            switch response {
                case .success(let movie):
                    self.currentMovie = movie
                    UIView.transition(
                       with: self.moviePoster,
                       duration: 0.5,
                       options: .transitionCrossDissolve,
                       animations: { [self] in
                           let url = URL(string: movie.posterUrl) ?? URL(fileURLWithPath: "1")
                           self.downloadImage(from: url)
                       },
                       completion: nil
                    )

                    self.movieTitle.text = movie.name
                    self.movieRating.text = String(movie.rating.imdb ?? 0.0)
                    self.movieDescription.text = movie.description

                    self.descriptionScrollableView.contentOffset = CGPoint.zero
                    self.posterBottomFade.locations = [0.4, 0.8, 1]

                case .failure(let error):
                    print(error.rawValue)
            }
        }

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
            descriptionScrollableView.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: 0)
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
            movieTitle.trailingAnchor.constraint(equalTo: movieYear.leadingAnchor),

            movieYear.bottomAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieYear.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -16),
            movieYear.widthAnchor.constraint(equalToConstant: 60),

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
            movieDescription.bottomAnchor.constraint(equalTo: descriptionScrollableView.bottomAnchor, constant: -16)
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

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        getData(from: url) { data, _, error in
            guard let data = data, error == nil, self == self else { return }
            DispatchQueue.main.async { [weak self] in
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
