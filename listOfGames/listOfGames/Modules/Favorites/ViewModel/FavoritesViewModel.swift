//
//  FavoritesViewModel.swift
//  listOfGames
//
//  Created by Роман Цуприк on 24.04.23.
//

import UIKit
import CoreData

class FavoritesViewModel {
    
    func fetchFavoritesGame (completions: ([Favorites]) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do {
            let results = try CoreDataManagers.instance.context.fetch(fetchRequest)
            completions(results as! [Favorites])
        } catch {
            print(error)
        }
    }
    
    func loadDataIntoImageView(link: String, completion: @escaping (UIImage) -> ()) {
        NetworkingManagers.shared.fetchImage(link: link) { data in
            completion(data)
        }
    }
}
