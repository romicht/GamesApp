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
        
//    let sessionConfiguration = URLSessionConfiguration.default
//    let session = URLSession.shared
//    let decoder = JSONDecoder()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        myTableView.frame = CGRect(x: 10, y: 30, width: 300, height: 300)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        myTableView.delegate = self
        myTableView.dataSource = self
        self.view.addSubview(myTableView)
        getRequest()
    }
        
        
//        guard let url1 = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url1) { data, response, error in
//            if let error = error {
//                print(error)
//                return
//            }
//            guard let data = data else { return }
//            let jsonString = String(data: data, encoding: .utf8)
//            debugPrint(jsonString!)
        
//            do {
//                let decoder = JSONDecoder()
//            let fullList = try decoder.decode([Lesson].self, from: data)
//                print(fullList)
////                print(fullList.first?.comments?.first?.user.name)
//            }catch {
//                print(error)
//            }
    //MARK: - Methods
        func getRequest() {
            let urlString = "https://api.rawg.io/api/games"
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let data = data else { return }
                let jsonString = String(data: data, encoding: .utf8)
                print(jsonString)
            }.resume()
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
