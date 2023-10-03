//
//  TitleSupplementaryView.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
  
  static let reuseIdentifier = String(describing: TitleSupplementaryView.self)
  
  let textLabel = UILabel()
  let seeAllButton = UIButton(type: .system)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    textLabel.text = nil
  }
  
  private func setViews() {
    addSubview(textLabel)
    addSubview(seeAllButton)
    textLabel.font = .manropeBold16
    seeAllButton.titleLabel?.font = .manropeRegular16
    seeAllButton.tintColor = .lightGray
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    seeAllButton.translatesAutoresizingMaskIntoConstraints = false
    
    let inset: CGFloat = 10
    
    NSLayoutConstraint.activate([
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      textLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
      
      seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      seeAllButton.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      seeAllButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
    ])
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init is not implemented")
  }
}
