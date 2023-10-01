//
//  HomeViewController.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

import UIKit
import SwiftUI

enum Section: Int, CaseIterable {
  case main
  case additinal
  case all
}

final class HomeViewController: UIViewController {
  
  private let homeView: HomeViewProtocol
  private lazy var dataSource = makeDataSource()
  
  
  let list = ProductList()
  let poscast = PodcastList()
  
  // MARK: - inits
  init(detailView: HomeViewProtocol) {
    self.homeView = detailView
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //  MARK: - Life Cycle
  override func loadView() {
    self.view = homeView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    homeView.collectionView.register(
      TitleSupplementaryView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: TitleSupplementaryView.reuseIdentifier
    )
    homeView.collectionView.dataSource = dataSource
    productListDidLoad(list, poscast)
  }
  
  enum Item: Hashable {
    case first(Product)
    case second(PodcastType)
    case third(Podcast)
  }
  
  func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
    let podcastCellRegistration = makeCellRegistration()
    let podcastButtonsCellRegistration = makeButtonsCellRegistration()
    let podcastTableCellRegistration = makeTableCellRegistration()
  
//    UICollectionViewDiffableDataSource<<#SectionIdentifierType: Hashable#>, Product>(
//      collectionView: detailView.collectionView,
//      cellProvider: makeCellRegistration().cellProvider
//    )
    
    return UICollectionViewDiffableDataSource(collectionView: homeView.collectionView) { collectionView, indexPath, item in
      switch item {
      case let .first(product):
        return collectionView.dequeueConfiguredReusableCell(
          using: podcastCellRegistration,
          for: indexPath,
          item: product
        )
      case let .second(podcast):
        return collectionView.dequeueConfiguredReusableCell(
          using: podcastButtonsCellRegistration,
          for: indexPath,
          item: podcast
        )
      case let .third(podcast):
        return collectionView.dequeueConfiguredReusableCell(
          using: podcastTableCellRegistration,
          for: indexPath,
          item: podcast
        )
      }
    }
  }
}


private extension HomeViewController {
  typealias Cell = CategoryCell
  typealias Title = TypeCell
  typealias Table = TableCell
  typealias CellRegistration = UICollectionView.CellRegistration<Cell, Product>
  typealias TableRegistration = UICollectionView.CellRegistration<Table, Podcast>
  typealias ButtonsRegistration = UICollectionView.CellRegistration<Title, PodcastType>
  
  func makeCellRegistration() -> CellRegistration {
    CellRegistration { cell, indexPath, product in
      cell.configure(with: product)
    }
  }
  
  func makeButtonsCellRegistration() -> ButtonsRegistration {
    ButtonsRegistration { cell, indexPath, product in
      cell.configure(with: product)
    }
  }
  
  func makeTableCellRegistration() -> TableRegistration {
    TableRegistration { cell, indexPath, product in
      cell.configure(with: product)
    }
  }
}

//private extension UICollectionView.CellRegistration {
//  var cellProvider: (UICollectionView, IndexPath, Item) -> Cell {
//    return { collectionView, indexPath, product in
//      collectionView.dequeueConfiguredReusableCell(
//        using: self,
//        for: indexPath,
//        item: product
//      )
//    }
//  }
//}

private extension HomeViewController {
  func productListDidLoad(_ list: ProductList, _ podcast: PodcastList) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(list.featured.map(Item.first), toSection: .main)
    snapshot.appendItems(PodcastType.allCases.map(Item.second), toSection: .additinal)
    snapshot.appendItems(podcast.all.map(Item.third), toSection: .all)
    
    dataSource.apply(snapshot)
    
    dataSource.supplementaryViewProvider =  { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) in
      
      if let titleSupplementayView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView {
        let tutorialCollection = ["Category", "", ""]
        switch Section(rawValue: indexPath.section) {
        case .main:
          titleSupplementayView.textLabel.text = tutorialCollection[indexPath.section]
          titleSupplementayView.numberLabel.text = "See all"
          return titleSupplementayView
          
        case .additinal:
          titleSupplementayView.textLabel.text = tutorialCollection[indexPath.section]
          return titleSupplementayView
          
        case .all:
          titleSupplementayView.textLabel.text = tutorialCollection[indexPath.section]
          return titleSupplementayView
        case nil:
          return nil
        }
        
      } else {
        return nil
      }
    }
  }
  
}

//  MARK: - Show Canvas
struct ContentViewController: UIViewControllerRepresentable {
  
  typealias UIViewControllerType = HomeViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    return HomeViewController(detailView: HomeView())
  }
  
  func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
  static var previews: some View {
    ContentViewController()
      .edgesIgnoringSafeArea(.all)
      .colorScheme(.light) // or .dark
  }
}

