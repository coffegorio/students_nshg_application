//
//  FeedbackScreenVC.swift
//  students_nshg_application
//
//  Created by Егорио on 15.12.2024.
//

import UIKit
import SnapKit

class FeedbackScreenVC: UIViewController {
    
    private let logoImage = CustomImageView(imageName: "logo")
    private let titleBackground = CustomBackground(cornerRadius: 16)
    private let titleLabel = CustomLabel(text: "", textColor: Styles.Colors.appThemeWhiteColor, textAlignment: .center, fontSize: 18, fontWeight: .bold)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupActions()
        fetchUserData()
        
    }
    
    private func setupUI() {
        view.backgroundColor = Styles.Colors.appThemeWhiteColor
        
        [
            logoImage,
            titleBackground,
            titleLabel
        ].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(40)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        
        titleBackground.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.centerY.equalTo(logoImage)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleBackground)
            make.centerY.equalTo(titleBackground)
        }
        
    }
    
    private func setupActions() {
        
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

        titleLabel.text = "\(name) \(surname)"

        if role == "student" {
            titleLabel.text = "Преподаватели"
        } else if role == "teacher" {
            titleLabel.text = "Ученики"
        } else {
            titleLabel.text = "\(role.capitalized)"
        }
    }
    
}

