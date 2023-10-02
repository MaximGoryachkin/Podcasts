//
//  HomeCollectionViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 02.10.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    let colorArray = [UIColor.customBlue, UIColor.customLightBlue, UIColor.peachPink, UIColor.seaBlue, UIColor.deepBlue, UIColor.backBlue, UIColor.seaGreen]
    let nameArray = ["Music and chill", "Social", "Comedy", "Sport", "Politics", "Fashion Trend", "Education", "Artificial Intellegence"]
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var subView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.8
        view.layer.cornerRadius = 6.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .equalCentering
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.font = .manropeBold14
        view.text = "Baby Pesut"
        view.textAlignment = .center
        return view
    }()
    
    private lazy var subtitle: UILabel = {
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
        addSubview(mainView)
        mainView.addSubview(subView)
        subView.addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            subView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            subView.rightAnchor.constraint(equalTo: mainView.rightAnchor),
            subView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -15),
            stackView.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: subView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: subView.topAnchor, constant: 15)
        ])
    }
    
    
    
}
