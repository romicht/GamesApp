//
//  DevelopersViewModel.swift
//  listOfGames
//
//  Created by Роман Цуприк on 9.04.23.
//

import UIKit

class DevelopersViewModel: UIViewController {

    // MARK: - Properties
    var developersVM = [DevelopersResults]()
    
    // MARK: - Methods
    func loadDataIntoTable(completion: @escaping () -> (), errorHandler: @escaping (LoadDataError) -> ()) {
        NetworkingManagers.shared.fethDevelopers { results in
            self.developersVM.append(contentsOf: results)
            completion()
        } errorHandler: { error in
            errorHandler(error)
        }
    }
    
    func loadDataIntoImageView(index: Int, completion: @escaping (UIImage) -> ()) {
        if let developerImage = self.developersVM[index].developerImage  {
        NetworkingManagers.shared.fetchImage(link: developerImage) { data in
            completion(data) }
        } else {
            completion(UIImage(named: "ImageNotFound")!)
            return
        }
    }
}
