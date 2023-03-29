//
//  GameDescriptionViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 28.03.23.
//

import UIKit

class GameDescriptionViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.layer.borderWidth = 1
            image.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var released: UILabel!
    //MARK: - Properties
    var model: Results?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateGD()
    }
    
    // MARK: - Methods
    func generateGD() {
        self.title = self.model!.name
        self.image.image = NetworkingManagers.shared.cachedDataSource.object(forKey: model!.background_image as NSString)
        self.id.text = String(self.model!.id)
        self.rating.text = String(self.model!.rating)
        self.released.text = String(self.model!.released)
    }
}
