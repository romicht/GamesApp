//
//  GameListModels.swift
//  listOfGames
//
//  Created by Роман Цуприк on 11.03.23.
//

import Foundation

struct List: Decodable {
    let count: Int
//    let next: String
//    let previous: String?
    let results: [Results]
}

struct Results: Decodable {
    let id: Int
//    let slug: String
    let name: String
    let released: String
//    let tba: Bool
    let background_image: String
    let rating: Double
//    let rating_top: Int
//    let ratings: [Ratings?]
//    let ratings_count: Int
//    let reviews_text_count: Int?
//    let added: Int
//    let added_by_status: AddedByStatus
//    let metacritic: Int
//    let playtime: Int
//    let suggestions_count: Int
//    let updated: String
//    let esrb_rating: EsrbRating
//    let platforms: [Platforms]
}

//struct Ratings: Codable {
//    let id: Int?
//    let title: String?
//    let count: Int?
//    let percent: Double?
//}

//struct AddedByStatus: Codable {
//    let yet: Int
//    let owned: Int
//    let beaten: Int
//    let toplay: Int
//    let dropped: Int
//    let playing: Int
//}

//struct EsrbRating: Codable {
//    let id: Int
//    let slug: String
//    let name: String
//}
//
//struct Platforms: Codable {
//    let platform: Platform?
//    let released_at: String?
//    let requirements: Requirements?
//}
//
//struct Platform: Codable {
//    let id: Int
//    let slug: String
//    let name: String
//}
//
//struct Requirements: Codable {
//    let minimum: String
//    let recommended: String
//}
