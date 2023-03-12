//
//  GameViewModel.swift
//  listOfGames
//
//  Created by Роман Цуприк on 11.03.23.
//

import Foundation

class GameViewModel {
    
    // MARK: - Properties
    private let urlString = "https://api.rawg.io/api/games?key=780cc9cdce0740e1a2b108c6cb9735b4"
    
    // MARK: - Methods
    func fethGames(completion: @escaping ([Results]) -> ()) {
        guard let url = URL(string: urlString) else { return }
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
}

