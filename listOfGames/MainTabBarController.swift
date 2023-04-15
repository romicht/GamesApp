//
//  MainTabBarController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 23.02.23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var gameVC = UIViewController()
    var gameNC = UINavigationController()
    var personVC = UIViewController()
    var personNC = UINavigationController()
    var settingVC = UIViewController()
    var settingNC = UINavigationController()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        generateVCs()
        generateNC()
        self.setViewControllers([gameNC, personNC, settingNC], animated: true)
    }
    
    private func generateVCs() {
        self.gameVC = generateVC(viewController: GamesViewController(), title: "Games", image: UIImage(systemName: "gamecontroller"))
        self.personVC = generateVC(viewController: DevelopersViewController(), title: "Developers", image: UIImage(systemName: "person"))
        self.settingVC = generateVC(viewController: SettingsViewController(), title: "Setting", image: UIImage(systemName: "seal"))
    }
    
    private func generateNC() {
        self.gameNC = UINavigationController(rootViewController: gameVC)
        self.personNC = UINavigationController(rootViewController: personVC)
        self.settingNC = UINavigationController(rootViewController: settingVC)
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}
