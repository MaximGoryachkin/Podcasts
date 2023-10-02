//
//  TypeCell.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

import UIKit

class TypeCell: UICollectionViewCell {
  private let title = makeTitle()
  
  override var isSelected: Bool {
    didSet {
      super.isSelected = isSelected
      
      switch isSelected {
      case true:
        title.font = .systemFont(ofSize: 20, weight: .bold)
      case false:
        title.font = .systemFont(ofSize: 20, weight: .light)
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.cornerRadius = 10
    addSubview(title)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setConstraints()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    title.text = nil
  }
  
  func configure(with category: PodcastType) {
    title.text = category.title
  }
}


extension TypeCell {
  static func makeTitle() -> UILabel {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 20, weight: .light)
    label.minimumScaleFactor = 0.8
    label.adjustsFontSizeToFitWidth = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: topAnchor),
      title.leftAnchor.constraint(equalTo: leftAnchor),
      title.rightAnchor.constraint(equalTo: rightAnchor),
      title.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
