//
//  GameDescriptionViewController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 28.03.23.
//

import UIKit

class GameDescriptionViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.layer.borderWidth = 1
            image.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var released: UILabel!
    @IBOutlet weak var genre: UILabel! {
        didSet {
            genre.text = ""
        }
    }
    @IBOutlet weak var screeshotsCollection: UICollectionView!
    
    //MARK: - Properties
    var viewModel = GameViewModel()
    var model: Results?
    var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        generateGD()
        screeshotsCollection.delegate = self
        screeshotsCollection.dataSource = self
            screeshotsCollection.register(UINib(nibName: "ScreenshotsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenshotsCollectionViewCell")
    }
    
    // MARK: - Methods
    func generateGD() {
        guard let model = self.model else { return }
        self.title = model.name
        self.image.image = NetworkingManagers.shared.cachedDataSource.object(forKey: model.backgroundImage as NSString)
        self.id.text = String(model.id)
        self.rating.text = String(model.rating)
        self.released.text = String(model.released)
        for genre in model.genres {
            guard let genre = genre.name else { return }
            self.genre.text? += "\(genre.lowercased()) "
        }
    }
}

extension GameDescriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotsCollectionViewCell", for: indexPath) as! ScreenshotsCollectionViewCell
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            guard let model = self.model else { return }
            self.viewModel.loadDataIntoScreenshots(gamesVM: model, index: indexPath.row) { [weak self] image in
                cell.addImage(image: image)
                self?.activityIndicator.stopAnimating()
                self?.view.isUserInteractionEnabled = true
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = self.model else { return 0 }
        return model.shortSreenshots.count
    }
}
