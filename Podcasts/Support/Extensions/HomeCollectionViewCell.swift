//
//  HomeTableViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 01.10.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    // MARK: - Properties
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: Fonts.boldFont, size: 14)
        return label
    }()
    
    private lazy var sublabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: Fonts.regularFont, size: 12)
        return label
    }()
    
    func configure() {
        
        contentView.addSubview(image)
        contentView.addSubview(labelStack)
        labelStack.addArrangedSubview(label)
        labelStack.addArrangedSubview(sublabel)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 48),
            image.widthAnchor.constraint(equalToConstant: 48),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelStack.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            labelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        self.image.image = .actions
        self.label.text = "label"
        self.sublabel.text = "sublabel"
    }
    
}
