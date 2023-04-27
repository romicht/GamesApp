//
//  GameViewModel.swift
//  listOfGames
//
//  Created by Роман Цуприк on 11.03.23.
//

import UIKit
import CoreData

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
        NetworkingManagers.shared.fetchImage(link: self.gamesVM[index].backgroundImage) { data in
            completion(data)
        }
    }
    
    func checkFavoriteGame(nameOfGames: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do {
            let results = try CoreDataManagers.instance.context.fetch(fetchRequest)
            for result in results as! [Favorites] {
                if nameOfGames == result.name {
                    return true
                }
            }
        } catch {
            print(error)
        }
        return false
    }
}

