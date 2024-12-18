//
//  RegistrationScreenVC.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

class RegistrationScreenVC: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let logoImageView = CustomImageView(imageName: "logo")
    private let titleBackground = CustomBackground(cornerRadius: 16)
    private let titleLabel = CustomLabel(text: "Регистрация", textColor: .white, textAlignment: .center, fontSize: 18, fontWeight: .bold)

    private let nameTextField = CustomTextField(placeholder: "Введите имя", cornerRadius: 16)
    private let surnameTextField = CustomTextField(placeholder: "Введите фамилию", cornerRadius: 16)
    private let emailTextField = CustomTextField(placeholder: "Введите электронную почту", cornerRadius: 16)
    private let passwordTextField = CustomTextField(placeholder: "Введите пароль", cornerRadius: 16)

    private let stageTextField = CustomTextField(placeholder: "Выберите ступень", cornerRadius: 16)
    private let lessonTextField = CustomTextField(placeholder: "Выберите урок", cornerRadius: 16)

    private let directionSegmentedControl: UISegmentedControl = {
        let items = ["Гитара", "Вокал", "Барабаны"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = .white
        control.backgroundColor = .black
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        return control
    }()

    private let registerButton = CustomButton(setTitle: "Зарегистрироваться")
    private let backButton = CustomButton(setTitle: "Назад")

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private let stagePickerView = UIPickerView()
    private let lessonPickerView = UIPickerView()
    private let stageOptions = ["1", "2", "3", "4"]
    private let lessonOptions = Array(1...24).map { "\($0)" }

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }

        setupUI()
        setupConstraints()
        setupActions()
        setupPickerViews()
        hideKeyboardWhenTappedAround()
        setupKeyboardObservers()
    }

    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.delaysContentTouches = false

        [
            logoImageView,
            titleBackground,
            titleLabel,
            nameTextField,
            surnameTextField,
            emailTextField,
            passwordTextField,
            stageTextField,
            lessonTextField,
            directionSegmentedControl,
            buttonStackView
        ].forEach { contentView.addSubview($0) }

        buttonStackView.addArrangedSubview(registerButton)
        buttonStackView.addArrangedSubview(backButton)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }

        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }

        titleBackground.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(titleBackground)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleBackground.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(nameTextField)
            make.height.equalTo(50)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(nameTextField)
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(nameTextField)
            make.height.equalTo(50)
        }

        stageTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(nameTextField)
            make.height.equalTo(50)
        }

        lessonTextField.snp.makeConstraints { make in
            make.top.equalTo(stageTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(nameTextField)
            make.height.equalTo(50)
        }

        directionSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(lessonTextField.snp.bottom).offset(40)
            make.leading.trailing.equalTo(nameTextField)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(directionSegmentedControl.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(30)
        }
    }

    private func setupPickerViews() {
        stagePickerView.delegate = self
        stagePickerView.dataSource = self
        lessonPickerView.delegate = self
        lessonPickerView.dataSource = self

        stageTextField.inputView = stagePickerView
        lessonTextField.inputView = lessonPickerView
    }

    private func setupActions() {
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }

    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func registerButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let stageText = stageTextField.text, let stageID = Int(stageText),
              let lessonText = lessonTextField.text, let currentLessonID = Int(lessonText) else {
            showAlert(title: "Ошибка", message: "Пожалуйста, заполните все поля.")
            return
        }

        let instrument = ["Гитара", "Вокал", "Барабаны"][directionSegmentedControl.selectedSegmentIndex]

        let userRequest = RegisterUserRequest(
            name: name,
            surname: surname,
            email: email,
            password: password,
            stageID: stageID,
            currentLessonID: currentLessonID,
            instrument: instrument,
            createdAt: Date()
        )

        AuthService.shared.registerUser(with: userRequest) { success, error in
            if success {
                print("Регистрация успешна!")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                print("Ошибка регистрации")
                DispatchQueue.main.async {
                    self.showAlert(title: "Ошибка", message: error?.localizedDescription ?? "Неизвестная ошибка")
                }
            }
        }
    }
    
    private func setupKeyboardObservers() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        
        @objc private func keyboardWillShow(_ notification: Notification) {
            guard let userInfo = notification.userInfo,
                  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            let keyboardHeight = keyboardFrame.height
            scrollView.contentInset.bottom = keyboardHeight
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        }
        
        @objc private func keyboardWillHide(_ notification: Notification) {
            scrollView.contentInset.bottom = 0
            scrollView.verticalScrollIndicatorInsets.bottom = 0
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
    }

extension RegistrationScreenVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == stagePickerView ? stageOptions.count : lessonOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == stagePickerView ? stageOptions[row] : lessonOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == stagePickerView {
            stageTextField.text = stageOptions[row]
        } else if pickerView == lessonPickerView {
            lessonTextField.text = lessonOptions[row]
        }
    }
}
