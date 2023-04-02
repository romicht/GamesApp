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
    func loadDataIntoTable(completion: @escaping () -> (), errorHandler: @escaping (LoadDataError) -> ()) {
        NetworkingManagers.shared.fethGames { results in
            self.gamesVM.append(contentsOf: results)
            completion()
        } errorHandler: { error in
            errorHandler(error)
        }
    }
    
    func loadDataIntoImageView(index: Int, completion: @escaping (UIImage) -> ()) {
        NetworkingManagers.shared.fetchImage(link: self.gamesVM[index].background_image) { data in
            completion(data)
        }
    }
}

