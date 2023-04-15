//
//  ScreenshotsCollectionViewCell.swift
//  listOfGames
//
//  Created by Роман Цуприк on 8.04.23.
//

import UIKit

class ScreenshotsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageScreenshot: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Methods
    func addImage(image: UIImage) {
        self.imageScreenshot.image = image
    }
}
