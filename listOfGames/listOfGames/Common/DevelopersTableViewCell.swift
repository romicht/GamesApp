//
//  DevelopersTableViewCell.swift
//  listOfGames
//
//  Created by Роман Цуприк on 15.04.23.
//

import UIKit

class DevelopersTableViewCell: UITableViewCell {
    @IBOutlet weak var conteinerView: UIView! {
        didSet {
            conteinerView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var developerPhoto: UIImageView! {
        didSet {
            developerPhoto.layer.cornerRadius = 5
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Properties
    static let identifire = "DevelopersTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DevelopersTableViewCell", bundle: nil)
    }
    
    //MARK: - Methods
    func configure(with model: DevelopersResults) {
        self.name.text = model.name
    }
    
    func setNumberOfRaw(number: Int) {
        self.number.text = String(number + 1)
    }
    
    func addImage(image: UIImage) {
        self.developerPhoto.image = image
    }
}
