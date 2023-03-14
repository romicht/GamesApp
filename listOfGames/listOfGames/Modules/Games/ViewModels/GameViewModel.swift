//
//  GameViewModel.swift
//  listOfGames
//
//  Created by Роман Цуприк on 11.03.23.
//

import UIKit

class GameViewModel {
    
    // MARK: - Properties
    var gamesVM = [Results]()
    
    // MARK: - Methods
    func loadDataIntoTable(completion: @escaping () -> ()) {
        NetworkingManagers.shared.fethGames { [weak self] (results) in
            self?.gamesVM = results
            completion()
        }
    }
    
    func loadDataIntoImageView(index: Int, completion: @escaping (Data) -> ()) {
        NetworkingManagers.shared.fetchImage(link: self.gamesVM[index].background_image) { imageData in
            completion(imageData)
        }
    }
}

