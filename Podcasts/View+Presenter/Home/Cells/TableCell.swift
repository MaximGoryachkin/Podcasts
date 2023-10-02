//
//  TableCell.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

import UIKit

class TableCell: UICollectionViewCell {
  private let podcastName = makeLabel(.systemFont(ofSize: 14, weight: .bold))
  private let authorName = makeLabel(.systemFont(ofSize: 12, weight: .light))
  private let podcastType = makeLabel(.systemFont(ofSize: 12, weight: .light))
  private let podcastQty = makeLabel(.systemFont(ofSize: 12, weight: .light))
  private let imageSquare = makeView()
  private let heartButton = makeButton()
  private let dotImage = makeImage()
  private let mainStack = makeVStack()
  private let firstStack = makeHStack()
  private let secondStack = makeHStack()
  
  //MARK: - init(_:)
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
      super.layoutSubviews()
      setConstraints()
  }
  
  override func prepareForReuse() {
      super.prepareForReuse()
    podcastName.text = nil
    authorName.text = nil
    podcastType.text = nil
    podcastQty.text = nil
  }
  
  //MARK: - Public methods
  func configure(with category: Podcast) {
    podcastName.text = category.podcastName
    authorName.text = category.authorName
    podcastType.text = category.podcastType
    podcastQty.text = category.episodeQty
  }
}

private extension TableCell {
  static func makeLabel(_ font: UIFont) -> UILabel {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = font
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
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
  
  static func makeButton() -> UIButton {
    let button = UIButton(type: .system)
    let grayHeard = UIImage(named: "greyHeart")
    button.setBackgroundImage(grayHeard, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }
  
  static func makeImage() -> UIImageView {
    let myImage = UIImageView()
    myImage.image = UIImage(named: "dot")
    myImage.contentMode = .center
    
    myImage.translatesAutoresizingMaskIntoConstraints = false
    return myImage
  }
  
  private func setViews() {
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 10
    firstStack.addArrangedSubview(podcastName)
    firstStack.addArrangedSubview(authorName)
    secondStack.addArrangedSubview(podcastType)
    secondStack.addArrangedSubview(dotImage)
    secondStack.addArrangedSubview(podcastQty)
    mainStack.addArrangedSubview(firstStack)
    mainStack.addArrangedSubview(secondStack)
    addSubview(imageSquare)
    addSubview(mainStack)
    addSubview(heartButton)
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      imageSquare.widthAnchor.constraint(equalToConstant: 56),
      imageSquare.heightAnchor.constraint(equalTo: imageSquare.widthAnchor),
      imageSquare.centerYAnchor.constraint(equalTo: centerYAnchor),
      imageSquare.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      
      mainStack.leadingAnchor.constraint(equalTo: imageSquare.trailingAnchor, constant: 16),
      mainStack.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      dotImage.widthAnchor.constraint(equalToConstant: 4),
      
      heartButton.widthAnchor.constraint(equalToConstant: 19),
      heartButton.heightAnchor.constraint(equalToConstant: 17),
      heartButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      heartButton.leadingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: 44),
      heartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    ])
  }
}
