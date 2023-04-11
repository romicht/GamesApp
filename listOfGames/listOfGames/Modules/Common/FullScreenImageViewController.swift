//
//  FullScreenImageViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 10.04.23.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    @IBOutlet weak var ImageView: UIImageView!
    
    var mainImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ImageView.image = self.mainImage
    }
 
}
