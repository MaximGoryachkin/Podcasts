//
//  TableViewCell.swift
//  Podcasts
//
//  Created by Miras Maratov on 29.09.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    var allNames = [
        "Between love and career",
        "The powerfull way to move on",
        "MOnkeys love make me curious",
        "How to beat your inner fear",
        "Who am I and what my purpose",
        "Why should you be baper",
        "Love and friends",
        "Comedy in stress life",
        "Work life balance",
        "Everyone is hero",
        "My first love",
    ]
    
    var infoArray = [
        "56:38 • 82 Eps",
        "24:40 • 40 Eps",
        "40:24 • 120 Eps",
        "24:38 • 21 Eps",
        "36:11 • 12 Eps",
        "14:34 • 24 Eps",
        "35:46 • 40 Eps",
        "43:34 • 12 Eps",
        "41:43 • 24 Eps",
        "34:12 • 24 Eps",
        "24:40 • 25 Eps",
    ]
    
    var index = 0
    
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
        element.layer.cornerRadius = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var podcastName: UILabel = {
        let element = UILabel()
        element.text = "The tale of greatest warrior"
        element.font = UIFont(name: "Manrope-Regular", size: 14)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var shortInfo: UILabel = {
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
//        reuseCell(name: allNames[index], info: infoArray[index])
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
    
    func reuseCell(name: String, info: String) {
        podcastName.text = name
        shortInfo.text = info
    }
}
