//
//  CategoryCell.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {
  
  lazy var podcastLabel: UILabel = {
    let element = UILabel()
    element.textColor = .black
    element.numberOfLines = 0
    element.font = .manropeBold12
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  lazy var podcastQty: UILabel = {
    let element = UILabel()
    element.textColor = .lightGray
    element.numberOfLines = 0
    element.font = .manropeRegular12
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var stackView: UIStackView = {
    let element = UIStackView()
    element.spacing = 5
    element.distribution = .fillEqually
    element.axis = .vertical
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var backImage: UIImageView = {
    let element = UIImageView()
    element.backgroundColor = #colorLiteral(red: 0.9954728484, green: 0.8505479693, blue: 0.8408355117, alpha: 1)
    element.layer.cornerRadius = 16
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  private lazy var frontView: UIView = {
    let element = UIView()
    element.backgroundColor = #colorLiteral(red: 1, green: 0.9450005889, blue: 0.9402258396, alpha: 1)
    element.layer.cornerRadius = 12
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }
  
  
  private func addViews() {
    backgroundColor = #colorLiteral(red: 0.9954728484, green: 0.8505479693, blue: 0.8408355117, alpha: 1)
    layer.cornerRadius = 16
    addSubview(frontView)
    frontView.addSubview(stackView)
    stackView.addArrangedSubview(podcastLabel)
    stackView.addArrangedSubview(podcastQty)
    
    NSLayoutConstraint.activate([
      frontView.bottomAnchor.constraint(equalTo: bottomAnchor),
      frontView.leadingAnchor.constraint(equalTo: leadingAnchor),
      frontView.trailingAnchor.constraint(equalTo: trailingAnchor),
      frontView.heightAnchor.constraint(equalToConstant: 70),
      
      stackView.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 20),
      stackView.centerYAnchor.constraint(equalTo: frontView.centerYAnchor),
    ])
  }
  
  func configure(with recipe: Product) {
    backImage.image = UIImage(systemName: recipe.imageName)
    podcastLabel.text = recipe.name
    podcastQty.text = "100"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
