//
//  blacknote.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 08.04.2022.
//


// MARK: -- scrollable view
//let blueViewController = UIViewController()
//blueViewController.view.backgroundColor = .systemBlue
//blueViewController.tabBarItem.title = "Blue"
//blueViewController.tabBarItem.image = .add
//
//let scrollView: UIScrollView = {
//    let v = UIScrollView()
//    v.translatesAutoresizingMaskIntoConstraints = false
//    v.backgroundColor = .cyan
//    return v
//}()
//let labelOne: UILabel = {
//    let label = UILabel()
//    label.text = "Scroll Top"
//    label.backgroundColor = .red
//    label.translatesAutoresizingMaskIntoConstraints = false
//    return label
//}()
//let labelTwo: UILabel = {
//    let label = UILabel()
//    label.text = "Scroll Bottom"
//    label.backgroundColor = .green
//    label.translatesAutoresizingMaskIntoConstraints = false
//    return label
//}()
//blueViewController.view.addSubview(scrollView)
//NSLayoutConstraint.activate([
//    scrollView.leftAnchor.constraint(equalTo: blueViewController.view.safeAreaLayoutGuide.leftAnchor, constant: 8.0),
//    scrollView.topAnchor.constraint(equalTo: blueViewController.view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
//    scrollView.rightAnchor.constraint(equalTo: blueViewController.view.safeAreaLayoutGuide.rightAnchor, constant: -8.0),
//    scrollView.bottomAnchor.constraint(equalTo: blueViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
//])
//
//scrollView.addSubview(labelOne)
//labelOne.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
//labelOne.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0).isActive = true
//
//scrollView.addSubview(labelTwo)
//labelTwo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
//labelTwo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true
//labelTwo.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16.0).isActive = true
//labelTwo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true





// MARK: -- Fade Layer
//let maskedView = UIView(frame: CGRect(x: 50, y: 50, width: 256, height: 256))
//maskedView.backgroundColor = ColorPalette.customYellow
//let gradientMaskLayer = CAGradientLayer()
//gradientMaskLayer.frame = maskedView.bounds
//gradientMaskLayer.colors = [UIColor.clear.cgColor, ColorPalette.customBlack.cgColor]
//gradientMaskLayer.locations = [0, 1]
//maskedView.layer.mask = gradientMaskLayer
//redViewController.view.addSubview(maskedView)




// MARK: -- movies
//    private let movies = [
//        Moviee(imageURL: "Leon", title: "Leon", year: 1994, producer: "Luc Besson", country: "France", ratingIMDB: 8.9, duration: 128, genre: ["Cool", "Calm"], description: "When 12-year-old Mathilda's family is killed, her neighbour Leon, who is a professional assassin, reluctantly takes her under his wing and teaches her the secrets of his trade"),
//        Moviee(imageURL: "Matrix", title: "Matrix", year: 1999, producer: "Wachowski brothers", country: "USA", ratingIMDB: 9.1, duration: 153, genre: ["Epic", "Juicy"], description: "Thomas Anderson, a computer programmer, is led to fight an underground war against powerful computers who have constructed his entire reality with a system called the Matrix"),
//        Moviee(imageURL: "Avatar", title: "Avatar", year: 2009, producer: "James Cameron", country: "USA", ratingIMDB: 9.0, duration: 137, genre: ["Nastolgia", "Wonderful"], description: "Jake, who is paraplegic, replaces his twin on the Na'vi inhabited Pandora for a corporate mission. After the natives accept him as one of their own, he must decide where his loyalties lie"),
//    ]


// MARK: -- tabBar

//        if isUserLogedIn() {
//            tabBarController.setViewControllers([
//                UINavigationController(rootViewController: cardView),
//                UINavigationController(rootViewController: ratedCollectionView),
//            ], animated: true)
//        } else {
//            tabBarController.setViewControllers([
//                UINavigationController(rootViewController: cardView),
//                UINavigationController(rootViewController: ratedCollectionView),
//            ], animated: true)
//        }
        

// MARK: -- MockNetwork
//    private var currentMovie = Movie(id: "0", title: "Title", posterURL: "URL", description: "Description", rating: 0.0, ratingBorder: 0.0)

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
