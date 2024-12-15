//
//  ProfileScreenVC.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit
import SnapKit

class ProfileScreenVC: UIViewController {

    private let logoutButton = CustomButton(setTitle: "Выйти из аккаунта")
    private let authService = AuthService.shared

    private let testAvatarLabel = CustomLabel(
        text: "Тут будет аватарка",
        textColor: Styles.Colors.appThemeBlackColor,
        textAlignment: .center,
        fontSize: 25,
        fontWeight: .bold
    )

    private let nameLabel = CustomLabel(
        text: "",
        textColor: Styles.Colors.appThemeBlackColor,
        textAlignment: .center,
        fontSize: 24,
        fontWeight: .bold
    )

    private let roleLabel = CustomLabel(
        text: "",
        textColor: Styles.Colors.appThemeGrayColor,
        textAlignment: .center,
        fontSize: 18,
        fontWeight: .regular
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        fetchUserData()
    }

    private func setupUI() {
        view.backgroundColor = Styles.Colors.appThemeWhiteColor
        view.addSubview(testAvatarLabel)
        view.addSubview(nameLabel)
        view.addSubview(roleLabel)
        view.addSubview(logoutButton)
    }

    private func setupConstraints() {
        testAvatarLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(testAvatarLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        roleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        logoutButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(200)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    private func setupActions() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    private func fetchUserData() {
        AuthService.shared.fetchUserData { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                self.updateUI(with: data)
            case .failure(let error):
                print("Ошибка получения данных пользователя: \(error.localizedDescription)")
            }
        }
    }

    private func updateUI(with data: [String: Any]) {
        let name = data["name"] as? String ?? "Имя не указано"
        let surname = data["surname"] as? String ?? "Фамилия не указана"
        let role = data["role"] as? String ?? "Роль не указана"

        nameLabel.text = "\(name) \(surname)"

        if role == "student" {
            roleLabel.text = "Ученик"
        } else if role == "teacher" {
            roleLabel.text = "Преподаватель"
        } else {
            roleLabel.text = "\(role.capitalized)"
        }
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
