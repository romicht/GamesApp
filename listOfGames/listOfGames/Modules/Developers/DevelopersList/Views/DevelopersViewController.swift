//
//  DevelopersViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 9.04.23.
//

import UIKit
import SnapKit

class DevelopersViewController: UIViewController {
    
    //MARK: - Properties
    var activityIndicator = UIActivityIndicatorView()
    var isLoadMore = false
    var viewModel = DevelopersViewModel()
    private lazy var developersTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DevelopersTableViewCell.nib().self,
                           forCellReuseIdentifier: DevelopersTableViewCell.identifire)
//        tableView.register(DevelopersHeaderView.nib().self, forHeaderFooterViewReuseIdentifier: "DevelopersHeaderView")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(developersTableView)
        constraint()
        loadData()
        setupActiveIndicator()
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    // MARK: - Methods
    private func loadData() {
        self.viewModel.loadDataIntoTable { [weak self] in
            print("Данные загружены")
            DispatchQueue.main.async {
                self?.developersTableView.tableFooterView = nil
                self?.isLoadMore = false
                self?.developersTableView.reloadData()
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
    
    private func constraint() {
        self.developersTableView.snp.updateConstraints { (make) in
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
extension DevelopersViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.developersVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = developersTableView.dequeueReusableCell(withIdentifier: DevelopersTableViewCell.identifire, for: indexPath) as! DevelopersTableViewCell
        let view = UIView()
        view.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = view
        cell.setNumberOfRaw(number: indexPath.row)
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            self.viewModel.loadDataIntoImageView(index: indexPath.row) { [weak self] image in
                cell.addImage(image: image)
                self?.activityIndicator.stopAnimating()
                self?.view.isUserInteractionEnabled = true
            }
        }
        cell.configure(with: viewModel.developersVM[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
//        return view
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let gameDescriptionVC = GameDescriptionViewController()
//        gameDescriptionVC.model = viewModel.gamesVM[indexPath.row]
//        navigationController?.pushViewController(gameDescriptionVC, animated: true)
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeit = developersTableView.contentSize.height
        if offsetY > 100 + contentHeit - scrollView.frame.height {
            self.developersTableView.tableFooterView = createSpinnerFooter()
            if !isLoadMore {
                beginLoadMore()
            }
        }
    }
    
    func beginLoadMore() {
        isLoadMore = true
        loadData()
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y:0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}

