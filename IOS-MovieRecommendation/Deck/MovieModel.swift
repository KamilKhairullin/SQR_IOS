//
//  MovieModel.swift
//  IOS-MovieRecommendation
//
//  Created by Bekzhan Talgat on 13.03.2022.
//

import Foundation


struct Movie {
    let imageURL: String
    
    let title: String
    let year: Int
    let producer: String
    let country: String
    let ratingIMDB: Float
    let duration: Int
//    let ageLimit: Int
    
    let genre: [String]
    let description: String
}

