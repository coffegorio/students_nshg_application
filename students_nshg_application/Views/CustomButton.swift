//
//  CustomButton.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

class CustomButton: UIButton {
    
    init(setTitle: String) {
        super.init(frame: .zero)
        
        self.setTitle(setTitle, for: .normal)
        self.setTitleColor(Styles.Colors.appThemeWhiteColor, for: .normal)
        self.backgroundColor = Styles.Colors.appThemeBlackColor
        self.layer.cornerRadius = 16
        self.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        self.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }
    }
    
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.05) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}
