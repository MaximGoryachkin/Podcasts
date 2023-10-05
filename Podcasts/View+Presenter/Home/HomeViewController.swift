//
//  HomeViewController.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

import UIKit

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

private extension HomeViewController {
  
  func productListDidLoad(_ list: ProductList, _ podcast: PodcastList) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(list.featured.map(Item.first), toSection: .main)
    snapshot.appendItems(PodcastType.allCases.map(Item.second), toSection: .additinal)
    snapshot.appendItems(podcast.all.map(Item.third), toSection: .all)
    
    dataSource.apply(snapshot)
    
    dataSource.supplementaryViewProvider =  { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) in
      
      guard let titleSupplementayView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView else { return UICollectionReusableView() }
      
      switch Section(rawValue: indexPath.section) {
      case .main:
        titleSupplementayView.textLabel.text = "Category"
        titleSupplementayView.seeAllButton.setTitle("See all", for: .normal)
        return titleSupplementayView
        
        //        case .additinal:
        //          titleSupplementayView.textLabel.text = tutorialCollection[indexPath.section]
        //          return titleSupplementayView
        //
        //        case .all:
        //          titleSupplementayView.textLabel.text = tutorialCollection[indexPath.section]
        //          return titleSupplementayView
      default:
        return nil
      }
    }
  }
}


