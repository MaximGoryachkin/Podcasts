//
//  TitleView.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

import UIKit

final class TitleView: UIView {
  private let nameLabel = makeLabel()
  private let podcastTypeLabel = makeLabel()
  private let squareView = makeView()
  private let mainStackView = makeVStack()
  
  // MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //  MARK: - Life Cycle
  override func layoutSubviews() {
    super.layoutSubviews()
    setConstraints()
  }
}

private extension TitleView {
  static func makeLabel() -> UILabel {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.minimumScaleFactor = 0.8
    label.textAlignment = .left
    label.adjustsFontSizeToFitWidth = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
  
  static func makeHStack() -> UIStackView {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.alignment = .leading
    stack.spacing = 2
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }
  
  static func makeVStack() -> UIStackView {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 5
    stack.distribution = .fill
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }
  
  static func makeView() -> UIView {
    let view = UIView()
    view.backgroundColor = .paleRose
    view.layer.cornerRadius = 16
    
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.5
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
  
  private func setViews() {
    nameLabel.text = "Hello"
    nameLabel.font = .manropeBold16
    nameLabel.textColor = .black
    podcastTypeLabel.text = "Nicely done"
    podcastTypeLabel.font = .manropeRegular14
    podcastTypeLabel.textColor = .lightGray
    mainStackView.addArrangedSubview(nameLabel)
    mainStackView.addArrangedSubview(podcastTypeLabel)
    addSubview(mainStackView)
    addSubview(squareView)
  }
  private func setConstraints() {
    NSLayoutConstraint.activate([
      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      squareView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      squareView.centerYAnchor.constraint(equalTo: centerYAnchor),
      squareView.widthAnchor.constraint(equalToConstant: 48),
      squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor)
    ])
  }
}
