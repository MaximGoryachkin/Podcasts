//
//  CollectionViewCell.swift
//  Podcasts
//
//  Created by Miras Maratov on 29.09.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let colorArray = [UIColor.customBlue, UIColor.customLightBlue, UIColor.peachPink, UIColor.seaBlue, UIColor.deepBlue, UIColor.backBlue, UIColor.seaGreen]
    let nameArray = ["Music and chill", "Social", "Comedy", "Sport", "Politics", "Fashion Trend", "Education", "Artificial Intellegence"]
    
    private let mainView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 12
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let nameLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: "Manrope-Regular", size: 14)
        element.textColor = .white
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    func configure() {
        addSubview(mainView)
        mainView.backgroundColor = colorArray.randomElement() ?? UIColor.systemMint
        addSubview(nameLabel)
        nameLabel.text = nameArray.randomElement() ?? "Music and Chill"
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 34),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -31),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
}
