//
//  SettingsScreenVC.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit
import SnapKit

class SettingsScreenVC: UIViewController {
    
    private let logoImage = CustomImageView(imageName: "logo")
    private let titleBackground = CustomBackground(cornerRadius: 16)
    private let titleLabel = CustomLabel(text: "Настройки", textColor: Styles.Colors.appThemeWhiteColor, textAlignment: .center, fontSize: 18, fontWeight: .bold)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupActions()
        
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
    
}
