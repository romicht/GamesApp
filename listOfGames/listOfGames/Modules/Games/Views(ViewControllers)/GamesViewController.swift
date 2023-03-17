//
//  GamesViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 23.02.23.
//

import UIKit
import SnapKit

class GamesViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel = GameViewModel()
    private lazy var gametableView: UITableView = {
        let tableView = UITableView()
//        tableView.frame = CGRect(x: 10, y: 30, width: 300, height: 600)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameTableViewCell.nib().self,
                           forCellReuseIdentifier: GameTableViewCell.identifire)
//        tableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: GameTableViewCell.identifire)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(gametableView)
        constraint()

        view.backgroundColor = .green
        self.viewModel.loadDataIntoTable { [weak self] in
            DispatchQueue.main.async {
                self?.gametableView.reloadData()
            }
        }
    }
    
    // MARK: - Methods
    private func constraint() {
        self.gametableView.snp.updateConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - Extension
extension GamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.gamesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gametableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifire, for: indexPath) as! GameTableViewCell
        cell.setNumberOfRaw(number: indexPath.row)
        self.viewModel.loadDataIntoImageView(index: indexPath.row) { imageData in
            DispatchQueue.main.async {
                cell.gameImage.image = UIImage(data: imageData)
            }
        }
        cell.configure(with: viewModel.gamesVM[indexPath.row])
//        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let headerView = gametableView.dequeueReusableHeaderFooterView(withIdentifier: GameTableViewCell.identifire) as! GameTableViewCell
////    headerView.sectionTitleLabel.text = "TableView Heder \(section)"
//    return headerView
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return 65
//    }
}

