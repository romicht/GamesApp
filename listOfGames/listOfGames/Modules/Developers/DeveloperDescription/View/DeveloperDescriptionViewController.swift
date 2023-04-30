//
//  DeveloperDescriptionViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 16.04.23.
//

import UIKit

class DeveloperDescriptionViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var developers: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var countsOfGames: UILabel!
    
    
    
    //MARK: - Properties
    var model: DevelopersResults?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateDD()
    }
    
    // MARK: - Methods
    func generateDD() {
        guard let model = self.model else { return }
        guard let image = model.developerImage else { return }
        self.backgroundImage.image = NetworkingManagers.shared.cachedDataSource.object(forKey: image as NSString)
        self.id.text = String(model.id)
        guard let count = model.gameCounts else { return }
        self.countsOfGames.text = String(count)
        self.developers.text = model.name
    }
}
