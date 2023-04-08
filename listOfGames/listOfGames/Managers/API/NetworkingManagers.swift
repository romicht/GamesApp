//
//  NetworkingManagers.swift
//  listOfGames
//
//  Created by Роман Цуприк on 11.03.23.
//
import Foundation
import UIKit

enum LoadDataError {
    case netWorkError
    case parsingError
}

class NetworkingManagers {

    //MARK: - Properties
    static let shared = NetworkingManagers()
    var cachedDataSource = NSCache<NSString, UIImage>()
    var numberOfPage: Int = 1
    //MARK: - Methods
    func fethGames(completion: @escaping ([Results]) -> (), errorHandler: @escaping (LoadDataError) -> ()) {
        guard let url = URL(string: "\(Constansts.urlGameRawg)?key=\(Constansts.apiKeyRawg)&page=\(numberOfPage)") else { return }
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
            self.numberOfPage += 1
        }.resume()
    }
    
    func fetchImage(link urlString: String, completion: @escaping (UIImage) -> ()) {
        let url = URL(string: urlString)
        if let cachedImage = cachedDataSource.object(forKey: urlString as NSString) {
            completion(cachedImage)
        } else {
            let data = try? Data(contentsOf: url!)
            if let image = UIImage(data: data!) {
            cachedDataSource.setObject(image, forKey: urlString as NSString)
            completion(image)
            }
        }
    }
    
    func fetchScreenshots(link urlString: String, completion: @escaping (UIImage) -> ()) {
        let url = URL(string: urlString)
        if let cachedImage = cachedDataSource.object(forKey: urlString as NSString) {
            completion(cachedImage)
        } else {
            let data = try? Data(contentsOf: url!)
            if let image = UIImage(data: data!) {
            cachedDataSource.setObject(image, forKey: urlString as NSString)
            completion(image)
            }
        }
    }
}

