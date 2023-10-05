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
    
    var podcasts = [Podcast]()
    var items = [PodcastItem]()
    var item = PodcastItem()
    var xmlDict = [String: String]()
    var xmlDictArr = [[String: String]]()
    var currentElement = ""
    let list = ProductList()
    
    
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
        productListDidLoad(list, podcasts)
        
        NetworkManager.shared.fetchDataSearchPodcast(from: DataManager.shared.trendingURL) { podcast in
            guard let feeds = podcast.feeds else { return }
            for feed in feeds {
                var newPodcast = Podcast(podcastName: feed.title, authorName: feed.author, podcastType: "News", episodeQty: "0")
                if let url = feed.url {
//                    self.fetchData(from: url)
                }
                newPodcast.items = self.items
                newPodcast.episodeQty = String(self.items.count)
                self.podcasts.append(newPodcast)
                DispatchQueue.main.async {
                    self.podcasts.forEach {
                        print($0.podcastName)
                        self.productListDidLoad(self.list, self.podcasts)
                        self.homeView.podcasts = self.podcasts
                    }
                }
            }
        }
    }
    
    func fetchData(from url: String) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("dataTaskWithRequest error: \(error)")
            }
            guard let data = data else { return }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }.resume()
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
    
    func productListDidLoad(_ list: ProductList, _ podcast: [Podcast]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list.featured.map(Item.first), toSection: .main)
        snapshot.appendItems(PodcastType.allCases.map(Item.second), toSection: .additinal)
        snapshot.appendItems(podcast.map(Item.third), toSection: .all)
        
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

extension HomeViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            xmlDict = [:]
            item = PodcastItem()
        } else {
            currentElement = elementName
        }
        if let url = attributeDict["url"], let length = attributeDict["length"] {
            item.url = url
            item.length = Int(length) ?? 0
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            xmlDictArr.append(xmlDict)
            if let description = xmlDict["description"]?.filter({ $0 != "\"" }).split(separator: "\n").first {
                item.description = String(description)
            }
            item.title = String((xmlDict["title"]?.filter { $0 != "\"" }.split(separator: "\n").first)!)
            items.append(item)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if xmlDict[currentElement] == nil {
            xmlDict[currentElement] = ""
        }
        xmlDict[currentElement]! += string
    }
}
