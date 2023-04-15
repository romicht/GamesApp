//
//  DevelopersListModel.swift
//  listOfGames
//
//  Created by Роман Цуприк on 15.04.23.
//

import Foundation

struct DevelopersList: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [DevelopersResults]
}

struct DevelopersResults: Decodable {
    let id: Int
    let name: String?
    let gameCounts: Int?
    let developerImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case gameCounts = "games_count"
        case developerImage = "image_background"
    }
}




