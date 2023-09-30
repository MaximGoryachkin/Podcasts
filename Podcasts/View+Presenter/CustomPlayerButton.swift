//
//  CustomPlayerButton.swift
//  Podcasts
//
//  Created by Максим Горячкин on 29.09.2023.
//

import UIKit

class CustomPlayerButton: UIButton {
    var image: UIImage!
    var color: UIColor!
    
    override func layoutSubviews() {
        setImage(image, for: .normal)
        tintColor = color
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 24).isActive = true
        widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
}
