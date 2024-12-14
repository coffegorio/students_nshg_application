//
//  SceneDelegate.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(windowScene: windowScene)
        
        let tabbarController = UITabBarController()
        tabbarController.tabBar.backgroundImage = UIImage()
        tabbarController.tabBar.tintColor = Styles.Colors.appThemeBlackColor
        tabbarController.tabBar.unselectedItemTintColor = Styles.Colors.appThemeGrayColor
        
        let newsScreenVC = NewsScreenVC()
        newsScreenVC.tabBarItem.image = UIImage(systemName: "newspaper")
        newsScreenVC.tabBarItem.selectedImage = UIImage(systemName: "newspaper.fill")
        
        let profileScreenVC = AuthScreenVC()
        profileScreenVC.tabBarItem.image = UIImage(systemName: "person")
        profileScreenVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        let settingsScreenVC = SettingsScreenVC()
        settingsScreenVC.tabBarItem.image = UIImage(systemName: "gearshape")
        settingsScreenVC.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        
        tabbarController.viewControllers = [newsScreenVC, profileScreenVC, settingsScreenVC]
        
        self.window?.rootViewController = tabbarController
        self.window?.makeKeyAndVisible()
    }
}
