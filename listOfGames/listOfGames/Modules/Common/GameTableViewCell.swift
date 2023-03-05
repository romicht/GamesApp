//
//  GameTableViewCell.swift
//  listOfGames
//
//  Created by Роман Цуприк on 5.03.23.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameRatings: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let identifire = "GameTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "GameTableViewCell", bundle: nil)
    }
    func configure(with model: Results) {
        self.gameName.textAlignment = .left
        self.gameRatings.textAlignment = .left
        self.gameName.text = model.name
        self.gameRatings.text = String(model.rating)
        self.changeImage(link: model.background_image)
        self.gameImage.contentMode = .scaleAspectFit
    }
    func changeImage(link: String){
        let url = URL(string: link)
        let data = try? Data(contentsOf: url!)
        gameImage.image = UIImage(data: data!)
    }
}
