//
//  ForgotPasswordScreenVC.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit
import SnapKit
import Combine

class ForgotPasswordScreenVC: UIViewController {
    
    private let authService = AuthService.shared

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let logoImage = CustomImageView(imageName: "logo")
    private let titleBackground = CustomBackground(cornerRadius: 16)
    private let titleLabel = CustomLabel(
        text: "Забыли пароль?",
        textColor: Styles.Colors.appThemeWhiteColor,
        textAlignment: .center,
        fontSize: 18,
        fontWeight: .bold
    )
    private let subtitleLabel = CustomLabel(
        text: "Введите вашу электронную почту, и мы отправим вам инструкции для восстановления пароля.",
        textColor: Styles.Colors.appThemeBlackColor,
        textAlignment: .left,
        fontSize: 16,
        fontWeight: .regular
    )
    private let emailTextField = CustomTextField(
        placeholder: "Введите электронную почту",
        cornerRadius: 16
    )
    private let resetPasswordButton = CustomButton(setTitle: "Сбросить пароль")
    private let backToAuthButton = CustomButton(setTitle: "Вернуться к авторизации")
    
    private var cancallable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupActions()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupUI() {
        self.view.backgroundColor = Styles.Colors.appThemeWhiteColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.delaysContentTouches = false
        
        [
            logoImage,
            titleBackground,
            titleLabel,
            subtitleLabel,
            emailTextField,
            resetPasswordButton,
            backToAuthButton
        ].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }

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
            make.center.equalTo(titleBackground)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        backToAuthButton.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(30) // Для скроллинга
        }
    }
    
    private func setupActions() {
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordTapped), for: .touchUpInside)
        backToAuthButton.addTarget(self, action: #selector(backToAuthTapped), for: .touchUpInside)
    }
    
    @objc private func resetPasswordTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        authService.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showInvalidEmailAlert(on: self)
            } else {
                AlertManager.showPasswordResetSent(on: self)
            }
        }
    }
    
    @objc private func backToAuthTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
