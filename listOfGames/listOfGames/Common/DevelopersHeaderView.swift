//
//  DevelopersHeaderView.swift
//  listOfGames
//
//  Created by Роман Цуприк on 16.04.23.
//

import UIKit

class DevelopersHeaderView: UITableViewHeaderFooterView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Properties
    static let identifire = "DevelopersHeaderView"
    static func nib() -> UINib {
        return UINib(nibName: "DevelopersHeaderView", bundle: nil)
    }
}
