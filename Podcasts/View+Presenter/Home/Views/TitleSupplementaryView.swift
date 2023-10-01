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
  let numberLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    textLabel.text = nil
    numberLabel.text = nil
  }
  
  private func setViews() {
    addSubview(textLabel)
    addSubview(numberLabel)
    textLabel.font = .preferredFont(forTextStyle: .title2)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    numberLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let inset: CGFloat = 10
    
    NSLayoutConstraint.activate([
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      textLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
      
      //numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
    ])
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init is not implemented")
  }
}
