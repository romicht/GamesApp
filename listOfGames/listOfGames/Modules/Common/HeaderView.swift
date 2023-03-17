//
//  HeaderView.swift
//  listOfGames
//
//  Created by Роман Цуприк on 17.03.23.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Properties
    static let identifire = "HeaderView"
    static func nib() -> UINib {
        return UINib(nibName: "HeaderView", bundle: nil)
    }

}
