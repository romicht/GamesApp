//
//  FullScreenImageViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 10.04.23.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    @IBOutlet weak var ImageView: UIImageView!
    
    //MARK: - Properties
    var mainImage: UIImage?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ImageView.image = self.mainImage
    }
 
}
