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
        
        view.backgroundColor = .black
        
        setupViews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    
    
// MARK: -- functions
    
    private func setupViews() {
        
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
