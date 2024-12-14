//
//  AuthScreenVC.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit
import SnapKit

class AuthScreenVC: UIViewController {
    
    private let authService = AuthService.shared

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let logoImage = CustomImageView(imageName: "logo")
    private let titleBackground = CustomBackground(cornerRadius: 16)
    private let titleLabel = CustomLabel(text: "Авторизация", textColor: Styles.Colors.appThemeWhiteColor, textAlignment: .center, fontSize: 18, fontWeight: .bold)
    private let subtitleLabel = CustomLabel(text: "Войдите в свою учетную запись, чтобы мы могли удостовериться, что вы действительно наш ученик :)...Возможно...", textColor: Styles.Colors.appThemeBlackColor, textAlignment: .left, fontSize: 20, fontWeight: .regular)
    private let emailTextField = CustomTextField(placeholder: "Введите электронную почту", cornerRadius: 16)
    private let passwordTextField = CustomTextField(placeholder: "Введите пароль", cornerRadius: 16)
    private let authButton = CustomButton(setTitle: "Войти")
    private let moveToRegistrationScreenButton = CustomButton(setTitle: "Зарегистрироваться")
    private let moveToForgotPasswordScreenButton = CustomButton(setTitle: "Забыли пароль?")

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupActions()
        hideKeyboardWhenTappedAround()
        setupKeyboardObservers()
    }

    private func setupUI() {
        view.backgroundColor = Styles.Colors.appThemeWhiteColor

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.delaysContentTouches = false

        [
            logoImage,
            titleBackground,
            titleLabel,
            subtitleLabel,
            emailTextField,
            passwordTextField,
            authButton,
            buttonStackView
        ].forEach { contentView.addSubview($0) }

        buttonStackView.addArrangedSubview(moveToRegistrationScreenButton)
        buttonStackView.addArrangedSubview(moveToForgotPasswordScreenButton)
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
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(emailTextField)
            make.height.equalTo(50)
        }

        authButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(passwordTextField)
            make.height.equalTo(50)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(authButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(authButton)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    private func setupActions() {
        moveToRegistrationScreenButton.addTarget(self, action: #selector(showRegistrationScreen), for: .touchUpInside)
        authButton.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
    }
    
    @objc private func authButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Отображаем ошибку, если поля пустые
            AlertManager.showSignInErrorAlert(on: self)
            return
        }
        
        let loginRequest = LoginUserRequest(email: email, password: password)
        
        // Вызов метода signInUser через экземпляр AuthService
        authService.signInUser(with: loginRequest) { error in
            if let error = error {
                // Ошибка входа
                AlertManager.showSignInErrorAlert(on: self, with: error)
            } else {
                // Успешный вход
                print("Пользователь успешно вошел в аккаунт")
                // Здесь можно добавить переход на главный экран или другую логику
            }
        }
    }

    @objc private func showRegistrationScreen() {
        let registerVC = RegistrationScreenVC()
        modalPresentationStyle = .fullScreen
        present(registerVC, animated: true, completion: nil)
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            scrollView.contentInset.bottom = keyboardHeight
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
