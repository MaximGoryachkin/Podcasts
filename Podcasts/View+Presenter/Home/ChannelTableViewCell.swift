//
//  ChannelTableViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 04.10.2023.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {
    
    static let identifier = "ChannelTableViewCell"
    
    private lazy var mainView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.929, green: 0.941, blue: 0.988, alpha: 1)
        element.layer.cornerRadius = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var avatarView: UIImageView = {
        let element = UIImageView()
        element.backgroundColor = .customLightBlue
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var podcastName: UILabel = {
        let element = UILabel()
        element.text = "The tale of greatest warrior"
        element.font = UIFont(name: "Manrope-Regular", size: 14)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var shortInfo: UILabel = {
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
    
    private func setUpCell() {
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
    
    private func addViews() {
        addSubview(mainView)
        mainView.addSubview(avatarView)
        mainView.addSubview(podcastName)
        mainView.addSubview(shortInfo)
    }
    
    func updateLayer() {
        print(avatarView.bounds)
        Globals.changeLayer(of: avatarView)
    }
    
    func configure(with podcastItem: PodcastItem) {
        self.podcastName.text = podcastItem.title
    }
}