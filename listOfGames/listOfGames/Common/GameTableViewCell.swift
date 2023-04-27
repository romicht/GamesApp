//
//  GameTableViewCell.swift
//  listOfGames
//
//  Created by Роман Цуприк on 5.03.23.
//

import UIKit
import CoreData

class GameTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var isInFavorites: Bool = false
    var favoritGame: Favorites?
    var model: Results?
    
    //MARK: - Outlets
    @IBOutlet weak var conteinerView: UIView! {
        didSet {
            conteinerView.layer.shadowColor = UIColor.darkGray.cgColor
            conteinerView.layer.shadowOffset = CGSize(width: 1, height: 1)
            conteinerView.layer.shadowRadius = 16
            conteinerView.layer.shadowOpacity = 0.3
            conteinerView.layer.cornerRadius = 16
        }
    }
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var gameImage: UIImageView! {
        didSet {
            gameImage.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var gameRatings: UILabel!
    @IBOutlet weak var favorites: UIButton! {
        didSet {
            if !isInFavorites {
            self.favorites.setImage(UIImage(systemName: "star"), for: .normal)
                self.favorites.alpha = 0.3
            } else {
                self.favorites.setImage(UIImage(systemName: "star.fill"), for: .normal)
                self.favorites.alpha = 1
            }
        }
    }
    
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Properties
    static let identifire = "GameTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "GameTableViewCell", bundle: nil)
    }
    
    //MARK: - Actions
    @IBAction func addToFavorites(_ sender: Any) {
        if self.isInFavorites {
            removeMarkFavorites()
            deleteGame()
            self.isInFavorites = false
        } else {
            setMarkFavorites()
            saveGame()
            self.isInFavorites = true
        }
    }
    
    //MARK: - Methods
    func configure(with model: Results) {
        self.gameName.text = model.name
        self.id.text = String(model.id)
        self.gameRatings.text = String(model.rating)
        self.model = model
    }
    
   func configureFavorite(with model: Favorites) {
       self.gameName.text = model.name
       self.id.text = String(model.id)
       self.gameRatings.text = String(model.rating)
    }
    
    func configureMark(mark: Bool) {
        if !mark {
            self.favorites.setImage(UIImage(systemName: "star"), for: .normal)
                self.favorites.alpha = 0.3
            } else {
                self.favorites.setImage(UIImage(systemName: "star.fill"), for: .normal)
                self.favorites.alpha = 1
            }
    }
    
    func setNumberOfRaw(number: Int) {
        self.number.text = String(number + 1)
    }
    
    func addImage(image: UIImage) {
        self.gameImage.image = image
    }
    
    func setMarkFavorites() {
        self.favorites.setImage(UIImage(systemName: "star.fill"), for: .normal)
        self.favorites.alpha = 1
    }
    
    func removeMarkFavorites() {
        self.favorites.setImage(UIImage(systemName: "star"), for: .normal)
        self.favorites.alpha = 0.3
    }
    
    func saveGame() {
        let managedObject = Favorites()
        if let genres = self.model?.genres {
        for genre in genres {
            guard let genre = genre.name else { return }
            managedObject.genres? += "\(genre.lowercased()) "
        }
        }
        managedObject.backgroudImage = self.model?.backgroundImage
        if let id = self.model?.id {
        managedObject.id = Int16(id)
        }
        managedObject.name = self.model?.name
        if let rating = self.model?.rating {
        managedObject.rating = rating
        }
        managedObject.released = self.model?.released
        CoreDataManagers.instance.saveContext()
    }
    
    func deleteGame() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do {
            let results = try CoreDataManagers.instance.context.fetch(fetchRequest)
            for result in results as! [Favorites] {
                if self.gameName.text == result.name {
                    CoreDataManagers.instance.context.delete(result)
                }
            }
        } catch {
            print(error)
        }
    }
}






