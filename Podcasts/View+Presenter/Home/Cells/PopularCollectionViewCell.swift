//
//  PopularCollectionViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 02.10.2023.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCollectionViewCell"
    
    private let label: UILabel = {
        let view = UILabel()
        view.font = .manropeBold14
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configure(with title: String) {
        layer.cornerRadius = 5
        addSubview(label)
        label.text = title
        
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    
}
