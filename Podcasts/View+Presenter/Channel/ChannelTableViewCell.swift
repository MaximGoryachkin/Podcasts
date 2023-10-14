//
//  ChannelTableViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 04.10.2023.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {
    
    static let identifier = "ChannelTableViewCell"
    var isPressed = false
    var item: Item!
    
    private lazy var mainView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.929, green: 0.941, blue: 0.988, alpha: 1)
        element.layer.cornerRadius = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var podcastImage: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleToFill
        element.backgroundColor = .cellBackground
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var podcastName: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: "Manrope-Regular", size: 14)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var shortInfo: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var favoriteButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        view.tintColor = !isPressed ? .systemGray : .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(saveEpisode), for: .touchUpInside)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            
            podcastImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            podcastImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            podcastImage.heightAnchor.constraint(equalToConstant: 56),
            podcastImage.widthAnchor.constraint(equalToConstant: 56),
            
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            favoriteButton.heightAnchor.constraint(equalToConstant: 19),
            favoriteButton.widthAnchor.constraint(equalToConstant: 19),
            
            podcastName.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            podcastName.leadingAnchor.constraint(equalTo: podcastImage.trailingAnchor, constant: 20),
            podcastName.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -5),
            
            shortInfo.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            shortInfo.leadingAnchor.constraint(equalTo: podcastImage.trailingAnchor, constant: 20),
            shortInfo.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -5),
        ])
    }
    
    private func addViews() {
        addSubview(mainView)
        mainView.addSubview(podcastImage)
        contentView.addSubview(favoriteButton)
        mainView.addSubview(podcastName)
        mainView.addSubview(shortInfo)
    }
    
    func updateLayer() {
        Globals.changeLayer(of: podcastImage)
    }
    
    func configure(with podcastItem: Item) {
        item = podcastItem
        let url = URL(string: item.image)
        podcastImage.kf.setImage(with: url)
        podcastName.text = item.title
    }
    
    @objc func saveEpisode() {
        DataManager.shared.saveEpisode(with: item)
        isPressed.toggle()
        favoriteButton.tintColor = isPressed ? .red : .systemGray
    }
}
