//
//  AppDelegate.swift
//  listOfGames
//
//  Created by Роман Цуприк on 23.02.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        window?.rootViewController = UINavigationController(rootViewController: MainTabBarController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

