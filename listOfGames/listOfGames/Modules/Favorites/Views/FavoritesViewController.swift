//
//  SettingsViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 23.02.23.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    //MARK: - Properties
    var activityIndicator = UIActivityIndicatorView()
    var viewModel = FavoritesViewModel()
    var model = [Favorites]()
    private lazy var gametableView: UITableView = {
        let tableView = UITableView()
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
        setupActiveIndicator()
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        self.activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    // MARK: - Methods
    private func loadData() {
        self.viewModel.fetchFavoritesGame { [weak self] results in
            self?.model = results
            self?.gametableView.reloadData()
            print("Данные из core data загружены")
        }
    }
    
    private func constraint() {
        self.gametableView.snp.updateConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupActiveIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.red
        self.view.addSubview(activityIndicator)
    }
}

// MARK: - Extension
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gametableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifire, for: indexPath) as! GameTableViewCell
        let view = UIView()
        view.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = view
        cell.setNumberOfRaw(number: indexPath.row)
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            if let linkImage = self.model[indexPath.row].backgroudImage {
                self.viewModel.loadDataIntoImageView(link: linkImage) { [weak self] image in
                    cell.addImage(image: image)
                    self?.activityIndicator.stopAnimating()
                    self?.view.isUserInteractionEnabled = true
                }
            }
        }
        cell.configureFavorite(with: model[indexPath.row])
        cell.isInFavorites = true
        cell.configureMark(mark: cell.isInFavorites)
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
        return 25
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let gameDescriptionVC = GameDescriptionViewController()
//        gameDescriptionVC.model = viewModel.gamesVM[indexPath.row]
//        navigationController?.pushViewController(gameDescriptionVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

