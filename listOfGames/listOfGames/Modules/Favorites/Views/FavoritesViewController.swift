//
//  SettingsViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 23.02.23.
//

import UIKit
import CoreData

protocol TableViewCellDelegate: AnyObject {
    func showAlert(text: String)
    func reloadTableData()
}

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
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete all", for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constansts.entity)
        let sortDescriptor = NSSortDescriptor(key: Constansts.sortName, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManagers.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(gametableView)
        self.view.addSubview(deleteButton)
        constraint()
        setupActiveIndicator()
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
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
        }
    }
    
    private func constraint() {
        self.gametableView.snp.updateConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
            make.bottom.equalToSuperview().inset(150)
        }
        
        self.deleteButton.snp.updateConstraints { (make) in
            make.top.equalTo(self.gametableView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(50)
        }
    }
    
    func setupActiveIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.red
        self.view.addSubview(activityIndicator)
    }
    
    @objc func buttonPressed() {
        let alertController = UIAlertController(title: "Удалить все из избранного?", message: "", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            do {
                let results = try CoreDataManagers.instance.context.fetch(fetchRequest)
                for result in results as! [Favorites] {
                        CoreDataManagers.instance.context.delete(result)
                    }
            } catch {
                print(error)
            }
            CoreDataManagers.instance.saveContext()
            self?.viewWillAppear(true)
        }
        let actionNo = UIAlertAction(title: "Отмена", style: .destructive) { _ in
            return
        }
            alertController.addAction(actionYes)
            alertController.addAction(actionNo)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Extension
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, TableViewCellDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gametableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifire, for: indexPath) as! GameTableViewCell
        cell.delegate = self
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            do {
                let results = try CoreDataManagers.instance.context.fetch(fetchRequest)
                CoreDataManagers.instance.context.delete(results[indexPath.row] as! Favorites)
            } catch {
                print(error)
            }
            CoreDataManagers.instance.saveContext()
            viewWillAppear(true)
        }
    }
  
    
    func showAlert(text: String) {
        let alertController = UIAlertController(title: "", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default) {_ in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reloadTableData() {
        viewWillAppear(true)
    }
}


