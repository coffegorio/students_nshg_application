//
//  ProfileScreenVC.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

class ProfileScreenVC: UIViewController {
    
    private let logoutButton = CustomButton(setTitle: "Выйти из аккаунта")
    private let authService = AuthService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appThemeWhiteColor
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        logoutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupActions() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func logoutButtonTapped() {
        authService.signOut { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                // Отображаем ошибку, если выход не удался
                AlertManager.showLogoutError(on: self, with: error)
            } else {
                // Успешный выход
                print("Пользователь успешно вышел из аккаунта")
                self.updateTabBarForLoggedOutUser()
            }
        }
    }
    
    private func updateTabBarForLoggedOutUser() {
        guard let tabBarController = self.view.window?.rootViewController as? UITabBarController else {
            print("Не удалось получить TabBarController")
            return
        }
        
        let authScreenVC = AuthScreenVC()
        authScreenVC.tabBarItem.image = UIImage(systemName: "person")
        authScreenVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        // Обновляем второй таб на экран авторизации
        var viewControllers = tabBarController.viewControllers ?? []
        if viewControllers.count > 1 {
            viewControllers[1] = authScreenVC
            tabBarController.viewControllers = viewControllers
        }
        
        // Переключаемся на второй таб
        tabBarController.selectedIndex = 1
    }
}
