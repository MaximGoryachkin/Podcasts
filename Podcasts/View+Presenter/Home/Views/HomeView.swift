//
//  HomeView.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

import UIKit

protocol HomeViewProtocol: UIView {
  var collectionView: UICollectionView { get }
  var titleView: UIView { get }
}

final class HomeView: UIView, HomeViewProtocol {
  
  let collectionView = makeCollectionView()
  let titleView = makeView()
  
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

//  MARK: -  Private Methods
private extension HomeView {
  
  static func makeCollectionView() -> UICollectionView {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: makeCollectionViewLayout()
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }
  
  static func makeView() -> UIView {
    let titleView = TitleView()
    titleView.backgroundColor = .white
    titleView.translatesAutoresizingMaskIntoConstraints = false
    return titleView
  }
  
  static func makeCollectionViewLayout() -> UICollectionViewLayout {
    UICollectionViewCompositionalLayout { sectionIndex, environment in
      
      switch Section(rawValue: sectionIndex) {
      case .main:
        return makeGridLayoutSection()
      case .additinal:
        return makeCategoriesButtonLayoutSection()
      case .all:
        return makeListLayoutSection()
      case nil:
        return nil
      }
    }
  }
  
  static func makeGridLayoutSection() -> NSCollectionLayoutSection {
    // Each item will take up half of the width of the group
    // that contains it, as well as the entire available height:
//    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//      widthDimension: .fractionalWidth(1),
//      heightDimension: .fractionalHeight(1)
//    ))
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    
    //Each group will then take up the entire available
    //width, and set its height to half of that width, to
    //make each item square-shaped:
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.45),
        heightDimension: .fractionalWidth(0.65)
      ),
      subitem: item,
      count: 1
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
    section.boundarySupplementaryItems = [sectionHeader]
    section.orthogonalScrollingBehavior = .continuous
    return section
  }
  
  static func makeCategoriesButtonLayoutSection() -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalHeight(1)
      )
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
      let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(0.23),
          heightDimension: .estimated(44)
      )
      let group = NSCollectionLayoutGroup.horizontal(
          layoutSize: groupSize,
          subitems: [item]
      )
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      section.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
      return section
  }
  
  static func makeListLayoutSection() -> NSCollectionLayoutSection {
    // Here, each item completely fills its parent group:
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1)
    ))
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
    
    // Each group then contains just a single item, and fills
    // the entire available width, while defining a fixed
    // height of 50 points:
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .absolute(100)
      ),
      subitems: [item]
    )
    let section = NSCollectionLayoutSection(group: group)
    
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)
    return section
  }
  
  private func setViews() {
    backgroundColor = .white
    addSubview(titleView)
    addSubview(collectionView)
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      titleView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      titleView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      titleView.heightAnchor.constraint(equalToConstant: 80),
      
      collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
