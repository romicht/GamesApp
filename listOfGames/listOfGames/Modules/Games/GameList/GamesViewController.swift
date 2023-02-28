//
//  GamesViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 23.02.23.
//

import UIKit

class GamesViewController: UIViewController {
    // MARK: - GUI Variables
    let myTableView = UITableView()
    let data = ["Chess", "Domino", "Go", "Backgammon", "Sudoku"]
    let identifire = "MyCell"
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        myTableView.frame = CGRect(x: 10, y: 30, width: 300, height: 300)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        myTableView.delegate = self
        myTableView.dataSource = self
        self.view.addSubview(myTableView)
    }
}

// MARK: - Extension
extension GamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: identifire)
        
        cell?.textLabel?.text = data[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
