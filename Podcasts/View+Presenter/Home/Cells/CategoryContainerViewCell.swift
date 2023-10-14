//
//  CategoryContainerViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 04.10.2023.
//

import UIKit

class CategoryContainerViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryContainerViewCell"
    private let categories = PodcastCategory.allCases
    var podcastCategories = [CategoryItem]()
    weak var delegate: HomeViewProtocol!
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 144, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(mainCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func updateData() {
        mainCollectionView.reloadData()
    }
    
}

extension CategoryContainerViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        podcastCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: podcastCategories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryChannelVC = CategoryChannelViewController()
        categoryChannelVC.category = podcastCategories[indexPath.row]
        delegate.prepareNavigation(with: categoryChannelVC)
    }
    
}
