//
//  PopularContainerViewCell.swift
//  Podcasts
//
//  Created by Максим Горячкин on 04.10.2023.
//

import UIKit

class PopularContainerViewCell: UICollectionViewCell {
    
    static let identifier = "PopularContainerViewCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 44)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collection.delegate = self
        collection.dataSource = self
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
    
    func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension PopularContainerViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as? PopularCollectionViewCell else { return UICollectionViewCell() }
        cell.configure()
        return cell
    }
}
