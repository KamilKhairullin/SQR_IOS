//
//  RatedMovieCardView.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 08.04.2022.
//

import Foundation
import UIKit


class RatedMovieCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = .systemOrange
        let cornerRadius = 25.0
        layer.cornerRadius = cornerRadius
        
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
