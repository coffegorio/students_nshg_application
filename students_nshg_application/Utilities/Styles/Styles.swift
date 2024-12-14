//
//  Styles.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

struct Styles {
    
    struct Colors {
        
        static let appThemeWhiteColor = UIColor.white
        static let appThemeBlackColor = UIColor.black
        static let appThemeGrayColor = UIColor.lightGray
        static let opacityColor = UIColor.white.withAlphaComponent(0.5)
        
    }
    
    struct LabelSettings {
        static func configureDefaultLabel(_ label: UILabel) {
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
        }
    }
    
}
