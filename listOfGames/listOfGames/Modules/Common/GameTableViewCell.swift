//
//  GameTableViewCell.swift
//  listOfGames
//
//  Created by Роман Цуприк on 5.03.23.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var gameImage: UIImageView! {
        didSet {
            gameImage.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var gameRatings: UILabel!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Properties
    static let identifire = "GameTableViewCell"
    private var imageData: Data?
    static func nib() -> UINib {
        return UINib(nibName: "GameTableViewCell", bundle: nil)
    }
    
    //MARK: - Methods
    func configure(with model: Results) {
        self.gameImage.image = UIImage(data: imageData!)
        self.gameName.text = model.name
        self.id.text = String(model.id)
        self.gameRatings.text = String(model.rating)
    }
    func setNumberOfRaw(number: Int) {
        self.number.text = String(number + 1)

    }
    
    func changeImage(link model: Results){
        let url = URL(string: model.background_image)
        self.imageData = try? Data(contentsOf: url!)
    }
}
