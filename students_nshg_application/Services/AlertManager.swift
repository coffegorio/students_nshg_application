//
//  AlertManager.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

class AlertManager {
    
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

// MARK: - Показывать ошибки валидации
extension AlertManager {
    
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Некорректный Email", message: "Пожалуйста, введите корректный адрес электронной почты.")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Некорректный пароль", message: "Пароль должен быть не менее 8 символов.")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Некорректное имя пользователя", message: "Пожалуйста, введите корректное имя пользователя.")
    }
}

// MARK: - Ошибки регистрации
extension AlertManager {
    
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Неизвестная ошибка при регистрации", message: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Ошибка при регистрации", message: "\(error.localizedDescription)")
    }
}

// MARK: - Ошибки входа в систему
extension AlertManager {
    
    public static func showSignInErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Неизвестная ошибка входа в систему", message: nil)
    }
    
    public static func showSignInErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Ошибка входа в систему", message: "\(error.localizedDescription)")
    }
}

// MARK: - Ошибки выхода из системы
extension AlertManager {
    
    public static func showLogoutError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Ошибка выхода из системы", message: "\(error.localizedDescription)")
    }
}

// MARK: - Восстановление пароля
extension AlertManager {

    public static func showPasswordResetSent(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Ссылка для сброса пароля отправлена", message: nil)
    }
    
    public static func showErrorSendingPasswordReset(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Ошибка при отправке сброса пароля", message: "\(error.localizedDescription)")
    }
}

// MARK: - Ошибки получения пользователя
extension AlertManager {
    
    public static func showFetchingUserError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Ошибка получения пользователя", message: "\(error.localizedDescription)")
    }
    
    public static func showUnknownFetchingUserError(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Неизвестная ошибка получения пользователя", message: nil)
    }
}
