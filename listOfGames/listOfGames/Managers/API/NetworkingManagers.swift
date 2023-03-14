//
//  NetworkingManagers.swift
//  listOfGames
//
//  Created by Роман Цуприк on 11.03.23.
//

import Foundation

class NetworkingManagers {
    
    //MARK: - Properties
    static let shared = NetworkingManagers()
    //MARK: - Methods
    func fethGames(completion: @escaping ([Results]) -> ()) {
        guard let url = URL(string: "\(Constansts.urlGameRawg)?key=\(Constansts.apiKeyRawg)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
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
            let results = gameList.results
            completion(results)
        }.resume()
    }

    func fetchImage(link urlString: String, completion: @escaping (Data) -> ()) {
            let url = URL(string: urlString)
            let imageData = try? Data(contentsOf: url!)
            completion(imageData!)
    }
}
