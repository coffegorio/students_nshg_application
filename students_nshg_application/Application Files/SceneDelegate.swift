//
//  SceneDelegate.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // Основной контроллер табов
    var tabBarController: UITabBarController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(windowScene: windowScene)

        tabBarController = UITabBarController()
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.tintColor = Styles.Colors.appThemeBlackColor
        tabBarController?.tabBar.unselectedItemTintColor = Styles.Colors.appThemeGrayColor

        // Первый таб: Новости
        let newsScreenVC = NewsScreenVC()
        newsScreenVC.tabBarItem.image = UIImage(systemName: "newspaper")
        newsScreenVC.tabBarItem.selectedImage = UIImage(systemName: "newspaper.fill")

        // Второй таб: Авторизация или профиль
        let secondTabVC = createSecondTabVC()

        // Четвертый таб: Настройки
        let settingsScreenVC = SettingsScreenVC()
        settingsScreenVC.tabBarItem.image = UIImage(systemName: "gearshape")
        settingsScreenVC.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")

        // Инициализация контроллеров табов
        tabBarController?.viewControllers = [newsScreenVC, secondTabVC, settingsScreenVC]

        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        // Подписка на уведомление об изменении состояния авторизации
        NotificationCenter.default.addObserver(self, selector: #selector(updateFeedbackTab), name: .userLoggedInStatusChanged, object: nil)
    }

    // Метод для создания второго таба (профиль или авторизация)
    private func createSecondTabVC() -> UIViewController {
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
        return secondTabVC
    }

    // Метод для обновления таба FeedbackScreenVC
    @objc private func updateFeedbackTab() {
        if AuthService.shared.isUserLoggedIn() {
            let feedbackScreenVC = FeedbackScreenVC()
            feedbackScreenVC.tabBarItem.image = UIImage(systemName: "envelope")
            feedbackScreenVC.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")

            // Обновляем viewControllers
            if var viewControllers = self.tabBarController?.viewControllers {
                if !viewControllers.contains(where: { $0 is FeedbackScreenVC }) {
                    viewControllers.insert(feedbackScreenVC, at: 2) // Добавляем FeedbackScreen в нужное место
                    self.tabBarController?.viewControllers = viewControllers
                }
            }
        } else {
            // Если пользователь не авторизован, скрываем таб
            if var viewControllers = self.tabBarController?.viewControllers {
                viewControllers.removeAll { $0 is FeedbackScreenVC }
                self.tabBarController?.viewControllers = viewControllers
            }
        }
    }

    // Метод, который срабатывает при активации приложения
    func sceneDidBecomeActive(_ scene: UIScene) {
        // При активации приложения проверяем авторизацию
        updateFeedbackTab()
    }

    deinit {
        // Убираем подписку на уведомления при уничтожении объекта
        NotificationCenter.default.removeObserver(self)
    }
}

extension Notification.Name {
    static let userLoggedInStatusChanged = Notification.Name("userLoggedInStatusChanged")
}

