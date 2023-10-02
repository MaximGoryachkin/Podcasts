//
//  UIFont.swift
//  Podcasts
//
//  Created by Максим Горячкин on 23.09.2023.
//

import UIKit.UIFont

extension UIFont {
    static let manropeBold12 = UIFont(name: "Manrope-Bold", size: 12)
    static let manropeBold14 = UIFont(name: "Manrope-Bold", size: 14)
    static let manropeBold16 = UIFont(name: "Manrope-Bold", size: 16)
    
    static let manropeRegular12 = UIFont(name: "Manrope-Regular", size: 12)
    static let manropeRegular14 = UIFont(name: "Manrope-Regular", size: 14)
    static let manropeRegular16 = UIFont(name: "Manrope-Regular", size: 16)
}

enum Fonts {
    static let regularFont: String = "Manrope-Regular"
    static let boldFont: String = "Manrope-Bold"
}
