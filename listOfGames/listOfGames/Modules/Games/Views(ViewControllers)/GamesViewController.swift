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
        tableView.register(HeaderView.nib().self, forHeaderFooterViewReuseIdentifier: "HeaderView")
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
        } errorHandler: { error in
            DispatchQueue.main.async {
            switch error {
            case .netWorkError:
                let alertController = UIAlertController(title: "Warning", message: "Network error", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ок", style: .default) {_ in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            case .parsingError:
                let alertController = UIAlertController(title: "Warning", message: "Parsing of json error", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ок", style: .default) {_ in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
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
        self.viewModel.loadDataIntoImageView(index: indexPath.row) { result in
            switch result {
            case .success(let data) :
            DispatchQueue.main.async {
                cell.gameImage.image = UIImage(data: data)
            }
            case .failure:
                let alertController = UIAlertController(title: "Logo", message: "Image address does not exist", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ок", style: .default) {_ in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        cell.configure(with: viewModel.gamesVM[indexPath.row])
//        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

