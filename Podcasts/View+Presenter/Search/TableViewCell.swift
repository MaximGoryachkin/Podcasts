//
//  TableViewCell.swift
//  Podcasts
//
//  Created by Miras Maratov on 29.09.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    private let mainView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.929, green: 0.941, blue: 0.988, alpha: 1)
        element.layer.cornerRadius = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let avatarView: UIImageView = {
        let element = UIImageView()
        element.backgroundColor = .customLightBlue
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let podcastName: UILabel = {
        let element = UILabel()
        element.text = "The tale of greatest warrior"
        element.font = UIFont(name: "Manrope-Regular", size: 14)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let shortInfo: UILabel = {
        let element = UILabel()
        element.text = "56:38 • 82 Eps"
        element.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "TableViewCell")
        setUpCell()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setUpCell() {
        addViews()
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            avatarView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            avatarView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            avatarView.heightAnchor.constraint(equalToConstant: 56),
            avatarView.widthAnchor.constraint(equalToConstant: 56),
            
            podcastName.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            podcastName.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 20),
            podcastName.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            
            shortInfo.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            shortInfo.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 20),
            shortInfo.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
        ])
    }
    
    func addViews() {
        addSubview(mainView)
        mainView.addSubview(avatarView)
        mainView.addSubview(podcastName)
        mainView.addSubview(shortInfo)
    }
    
    func updateLayer() {
        Globals.changeLayer(of: avatarView)
    }
}
