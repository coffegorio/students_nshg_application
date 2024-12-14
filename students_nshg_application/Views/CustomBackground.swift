//
//  CustomBackground.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

class CustomBackground: UIView {

    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        self.backgroundColor = Styles.Colors.appThemeBlackColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
