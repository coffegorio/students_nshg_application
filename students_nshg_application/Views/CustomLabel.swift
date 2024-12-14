//
//  CustomLabel.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

class CustomLabel: UILabel {

    init(text: String, textColor: UIColor, textAlignment: NSTextAlignment, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: .zero)
        
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        Styles.LabelSettings.configureDefaultLabel(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

