//
//  CustomImage.swift
//  students_nshg_application
//
//  Created by Егорио on 13.12.2024.
//

import UIKit

class CustomImageView: UIImageView {

    init(imageName: String) {
        super.init(frame: .zero)
        
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
