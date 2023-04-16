//
//  GameDescriptionViewModel.swift
//  listOfGames
//
//  Created by Роман Цуприк on 16.04.23.
//

import UIKit

class GameDescriptionViewModel {
    
    // MARK: - Methods
    func loadDataIntoScreenshots(gamesVM: Results, index: Int, completion: @escaping (UIImage) -> ()) {
        NetworkingManagers.shared.fetchImage(link: gamesVM.shortSreenshots[index].image) { data in
            completion(data)
        }
    }
}

