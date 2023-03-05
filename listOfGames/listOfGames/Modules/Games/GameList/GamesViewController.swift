//
//  GamesViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 23.02.23.
//

import UIKit

class GamesViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var gametableView: UITableView = {
        let tableView = UITableView()
        // Type 1
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameTableViewCell.self,
                           forCellReuseIdentifier: GameTableViewCell.identifire)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var models = [Results]()
//    let sessionConfiguration = URLSessionConfiguration.default
//    let session = URLSession.shared
//    let decoder = JSONDecoder()
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(gametableView)
//
//        gameTableViewNew.register(GameTableViewCell.nib(), forCellReuseIdentifier: GameTableViewCell.identifire)
//        gameTableView.delegate = self
//        gameTableView.dataSource = self
        
        view.backgroundColor = .green
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
            let urlString = "https://api.rawg.io/api/games?key=780cc9cdce0740e1a2b108c6cb9735b4"
//            let urlString = "https://api.rawg.io/api/games"
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "Get"
//            request.allHTTPHeaderFields = [
//                "key": "780cc9cdce0740e1a2b108c6cb9735b4"
//            ]
//            request.addValue("780cc9cdce0740e1a2b108c6cb9735b4", forHTTPHeaderField: "key")
//            request.setValue("780cc9cdce0740e1a2b108c6cb9735b4", forHTTPHeaderField: "key")
//            request.setValue("780cc9cdce0740e1a2b108c6cb9735b4", forHTTPHeaderField: "key")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Validation
                guard let data = data, error == nil else {
                    print("something went wrong")
                    return
                }
                //Convert data to models/some object
                var json: List?
                do {
                    json = try JSONDecoder().decode(List.self, from: data)
                }
                catch {
                    print("error: \(error)")
                }
                guard let gameList = json else {
                    return
                }
//                print(json)
                let results = gameList.results
                self.models.append(contentsOf: results)
//                DispatchQueue.main.async {
//                    self.gameTableView.reloadData()
//                    self.table.tableHeaderView = self.createTableHeader()
//                }
            }.resume()
        }
}

// MARK: - Extension
extension GamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
//        return self.models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gametableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifire, for: indexPath) as! GameTableViewCell
        cell.configure()
//        cell.configure(with: models[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
    
struct List: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Results]
}

struct Results: Decodable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let tba: Bool
    let background_image: String
    let rating: Double
    let rating_top: Int
    let ratings: [Ratings?]
    let ratings_count: Int
    let reviews_text_count: Int?
    let added: Int
    let added_by_status: AddedByStatus
    let metacritic: Int
    let playtime: Int
    let suggestions_count: Int
    let updated: String
    let esrb_rating: EsrbRating
    let platforms: [Platforms]
}

struct Ratings: Codable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}

struct AddedByStatus: Codable {
    let yet: Int
    let owned: Int
    let beaten: Int
    let toplay: Int
    let dropped: Int
    let playing: Int
}

struct EsrbRating: Codable {
    let id: Int
    let slug: String
    let name: String
}

struct Platforms: Codable {
    let platform: Platform?
    let released_at: String?
    let requirements: Requirements?
}

struct Platform: Codable {
    let id: Int
    let slug: String
    let name: String
}

struct Requirements: Codable {
    let minimum: String
    let recommended: String
}

