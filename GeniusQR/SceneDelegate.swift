//
//  SceneDelegate.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 26/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = createRoot()
        window?.makeKeyAndVisible()
    }
    
    func createRoot() -> UIViewController {
        
        //Controllers
        let generateController = GenerateController()
        generateController.tabBarItem.title = "Generate"
        generateController.tabBarItem.image = UIImage(systemName: "qrcode")
        
        let historyController = HistoryController()
        historyController.tabBarItem.title = "History"
        historyController.tabBarItem.image = UIImage(systemName: "clock")
        
        let settingsController = SettingsController()
        settingsController.tabBarItem.title = "Settings"
        settingsController.tabBarItem.image = UIImage(systemName: "gear")
        
        
        //Navigation Controllers
        let navigationForGenerate = createNavigation(for: generateController)
        let navigationForHistory = createNavigation(for: historyController)
        let navigationForSettings = createNavigation(for: settingsController)
        
        let tabBar = UITabBarController()
        
        tabBar.viewControllers = [
            navigationForGenerate, navigationForHistory, navigationForSettings
        ]
        
        return tabBar
    }
    
    func createNavigation(for controller: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }
}

