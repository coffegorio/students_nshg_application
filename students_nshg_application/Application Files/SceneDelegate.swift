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
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundImage = UIImage()
        tabBarController.tabBar.tintColor = Styles.Colors.appThemeBlackColor
        tabBarController.tabBar.unselectedItemTintColor = Styles.Colors.appThemeGrayColor

        // Первый таб: Новости
        let newsScreenVC = NewsScreenVC()
        newsScreenVC.tabBarItem.image = UIImage(systemName: "newspaper")
        newsScreenVC.tabBarItem.selectedImage = UIImage(systemName: "newspaper.fill")

        // Второй таб: Авторизация или профиль
        let secondTabVC: UIViewController
        if AuthService.shared.isUserLoggedIn() {
            // Если пользователь авторизован, показываем профиль
            let profileScreenVC = ProfileScreenVC()
            profileScreenVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
            profileScreenVC.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
            secondTabVC = profileScreenVC
        } else {
            // Если пользователь не авторизован, показываем авторизацию
            let authScreenVC = AuthScreenVC()
            authScreenVC.tabBarItem.image = UIImage(systemName: "person")
            authScreenVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
            secondTabVC = authScreenVC
        }

        // Третий таб: Настройки
        let settingsScreenVC = SettingsScreenVC()
        settingsScreenVC.tabBarItem.image = UIImage(systemName: "gearshape")
        settingsScreenVC.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")

        // Устанавливаем контроллеры таббара
        tabBarController.viewControllers = [newsScreenVC, secondTabVC, settingsScreenVC]
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
}
