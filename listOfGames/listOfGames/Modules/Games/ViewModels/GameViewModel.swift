//
//  GameViewModel.swift
//  listOfGames
//
//  Created by Роман Цуприк on 11.03.23.
//

import Foundation
import UIKit

class GameViewModel {
    
    // MARK: - Properties
    var gamesVM = [Results]()
    
    // MARK: - Methods
    func loadDataInTable(tabel: UITableView, completion: @escaping ([Results]) -> ()) {
        NetworkingManagers.shared.fethGames { (results) in
            completion(results)
            DispatchQueue.main.async {
                tabel.reloadData()
            }
        }
        
    }
    
    
}

