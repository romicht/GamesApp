//
//  MainTabBarController.swift
//  listOfGames
//
//  Created by Роман Цуприк on 23.02.23.
//

import UIKit

class MainTabBarController: UITabBarController {
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        generateTabBar()
        setTabBarAppearance()
//        self.title = "Hi"
    }
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: GamesViewController(), title: "Games", image: UIImage(named: "games")),
            generateVC(viewController: PersonViewController(), title: "Personal info", image: UIImage(named: "person")),
            generateVC(viewController: SettingsViewController(), title: "Setting", image: UIImage(named: "settings"))
            
        ]
    }
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2

        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: height / 2)
        roundLayer.path = bezierPath.cgPath

        tabBar.layer.insertSublayer(roundLayer, at: 0)

        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered

        roundLayer.fillColor = UIColor.mainWhite.cgColor

        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
