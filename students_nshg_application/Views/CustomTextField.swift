//
//  CustomTextField.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

class CustomTextField: UITextField {

    init(placeholder: String, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        self.textColor = Styles.Colors.appThemeGrayColor
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = Styles.Colors.appThemeBlackColor
        
        // Устанавливаем атрибуты для плейсхолдера
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white // Белый цвет
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
    }
    
    // Переопределяем метод для задания отступов внутри текстового поля
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5) // Отступы внутри textfield
    }
    
    // Переопределяем метод для задания отступов для текста в placeholder
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5) // Отступы внутри placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

