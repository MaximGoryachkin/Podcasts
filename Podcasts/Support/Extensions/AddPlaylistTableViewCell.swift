//
//  AddPlaylistTableViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 01.10.2023.
//

import UIKit

class AddPlaylistTableViewCell: UITableViewCell {
    
    static let identifier = "AddPlaylistTableViewCell"
    
    // MARK: - Properties
    
    private let image: UIImageView = {
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: Fonts.boldFont, size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        contentView.addSubview(labelStack)
        labelStack.addArrangedSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 48),
            image.widthAnchor.constraint(equalToConstant: 48),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelStack.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5),
            labelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    public func configure(image: UIImage, label: String) {
        self.image.image = image
        self.label.text = label
    }
    
}
