//
//  UIImageView+Squircle.swift
//  Podcasts
//
//  Created by Максим Горячкин on 30.09.2023.
//

import UIKit

struct Globals {
    static func changeLayer(of view: UIView) {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.frame.height / 3.2).cgPath
        
        view.layer.mask = layer
    }
    
    static let trendingCategories = ["🔥Trending", "Live", "Random", "Recent"]
}
