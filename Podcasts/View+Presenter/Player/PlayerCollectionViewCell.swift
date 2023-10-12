//
//  PlayerCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 29.09.2023.
//

import UIKit
import Kingfisher

class PlayerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlayerCollectionViewCell"
    
    private lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

//        backgroundColor = .cellBackground
        contentView.addSubview(mainImageView)
//        contentView.layer.shadowColor = CGColor(gray: 0.8, alpha: 1)
//        contentView.layer.shadowRadius = 100
//        contentView.layer.shadowOpacity = 1
//        contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    func configure(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        mainImageView.kf.setImage(with: url)
    }
    
    func updateLayer() {
        Globals.changeLayer(of: mainImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
