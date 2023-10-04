//
//  PopularCollectionViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 02.10.2023.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCollectionViewCell"

    let nameArray = ["Music and chill", "Social", "Comedy", "Sport", "Politics", "Fashion Trend", "Education", "Artificial Intellegence"]
    
    private lazy var mainImage: UIImageView = {
        let view = UIImageView()
        view.image = .actions
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let title: UILabel = {
        let view = UILabel()
        view.font = .manropeBold14
        view.text = "Baby Pesut"
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    func configure() {
        layer.cornerRadius = 5
        addSubview(mainImage)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            mainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainImage.widthAnchor.constraint(equalToConstant: 16),
            mainImage.heightAnchor.constraint(equalToConstant: 16),
            mainImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: mainImage.rightAnchor, constant: 5),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    
}
