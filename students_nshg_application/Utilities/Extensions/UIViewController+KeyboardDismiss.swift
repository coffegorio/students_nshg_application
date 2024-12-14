//
//  UIViewController+KeyboardDismiss.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import Foundation
import UIKit

// Расширение для UIViewController
extension UIViewController {

    // Функция для скрытия клавиатуры при тапе вне текстового поля
    func hideKeyboardWhenTappedAround() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    // Метод для скрытия клавиатуры
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
