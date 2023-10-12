//
//  FavoriteCollectionViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 01.10.2023.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCollectionViewCell"
    
    let colorArray = [UIColor.customBlue, UIColor.customLightBlue, UIColor.peachPink, UIColor.seaBlue, UIColor.deepBlue, UIColor.backBlue, UIColor.seaGreen]
    let nameArray = ["Music and chill", "Social", "Comedy", "Sport", "Politics", "Fashion Trend", "Education", "Artificial Intellegence"]
    
    private let mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        view.textAlignment = .center
        return view
    }()
    
    private let subtitle: UILabel = {
        let view = UILabel()
        view.font = .manropeRegular12
        view.textColor = .systemGray
        view.text = "Dr. Oi om jean"
        view.textAlignment = .center
        return view
    }()
    
    func configure() {
        backgroundColor = .customLightBlue
        layer.cornerRadius = 20
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainImage)
        mainStackView.addArrangedSubview(title)
        mainStackView.addArrangedSubview(subtitle)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            mainImage.heightAnchor.constraint(equalToConstant: 60),
            mainImage.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    
}
