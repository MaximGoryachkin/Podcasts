//
//  HomeTableViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 01.10.2023.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    // MARK: - Properties
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 144, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        return layout
    }()
    
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
    
    func configure(with podcast: Podcast) {
        
        contentView.addSubview(image)
        contentView.addSubview(labelStack)
        labelStack.addArrangedSubview(label)
        labelStack.addArrangedSubview(sublabel)
        contentView.backgroundColor = .cellBackground
        contentView.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 48),
            image.widthAnchor.constraint(equalToConstant: 48),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelStack.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            labelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        let url = URL(string: podcast.image)
        image.kf.setImage(with: url)
        label.text = podcast.title
        sublabel.text = podcast.author

    }
    
}
