//
//  NetworkingManagers.swift
//  listOfGames
//
//  Created by Роман Цуприк on 11.03.23.
//
import UIKit

enum LoadDataError {
    case netWorkError
    case parsingError
}

class NetworkingManagers {

    //MARK: - Properties
    static let shared = NetworkingManagers()
    var cachedDataSource = NSCache<NSString, UIImage>()
    var numberOfPageGames: Int = 1
    var numberOfPageDevelopers: Int = 1
    
    //MARK: - Methods
    func fethGames(completion: @escaping ([Results]) -> (), errorHandler: @escaping (LoadDataError) -> ()) {
        guard let url = URL(string: "\(Constansts.urlGameRawg)?key=\(Constansts.apiKeyRawg)&page=\(numberOfPageGames)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Validation
            if error != nil {
                errorHandler(.netWorkError)
            }
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
                print(error)
                errorHandler(.parsingError)
            }
            guard let gameList = json else {
                return
            }
//            print(gameList.next)
            let results = gameList.results
            completion(results)
            self.numberOfPageGames += 1
        }.resume()
    }
    
    func fethDevelopers(completion: @escaping ([DevelopersResults]) -> (), errorHandler: @escaping (LoadDataError) -> ()) {
        guard let url = URL(string: "\(Constansts.urlDevelopers)?key=\(Constansts.apiKeyRawg)&page=\(numberOfPageDevelopers)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Validation
            if error != nil {
                errorHandler(.netWorkError)
            }
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            //Convert data to models/some object
            var json: DevelopersList?
            do {
                json = try JSONDecoder().decode(DevelopersList.self, from: data)
            }
            catch {
                print(error)
                errorHandler(.parsingError)
            }
            guard let developersList = json else {
                return
            }
            let results = developersList.results
            completion(results)
            self.numberOfPageDevelopers += 1
        }.resume()
    }
    
    func fetchImage(link urlString: String, completion: @escaping (UIImage) -> ()) {
        let url = URL(string: urlString)
        if let cachedImage = cachedDataSource.object(forKey: urlString as NSString) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, response, error in
                guard let data = data, error == nil else {
                    print("something went wrong")
                    return
                }
                if let image = UIImage(data: data) {
                    self.cachedDataSource.setObject(image, forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}

