//
//  GameListModels.swift
//  listOfGames
//
//  Created by Роман Цуприк on 11.03.23.
//

import Foundation

struct List: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Results]
}

struct Results: Decodable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let genres: [Genres]
    let shortSreenshots: [ShortSreenshots]
    
    enum CodingKeys: String, CodingKey {
        case id, name, released, rating, genres
        case backgroundImage = "background_image"
        case shortSreenshots = "short_screenshots"
    }
}

struct Genres: Decodable {
    let name: String?
}

struct ShortSreenshots: Decodable {
    let image: String
}
