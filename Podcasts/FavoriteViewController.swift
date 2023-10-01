//
//  FavoriteViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 30.09.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private lazy var headerStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerStackTitle: UILabel = {
        let view = UILabel()
        view.text = "Favorites"
        view.font = .manropeBold16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var allButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("See all", for: .normal)
        view.setTitleColor(.systemGray, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerTableTitle: UILabel = {
        let view = UILabel()
        view.text = "Your Playlist"
        view.font = .manropeBold16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(headerStack)
        headerStack.addArrangedSubview(headerStackTitle)
        headerStack.addArrangedSubview(allButton)
        view.addSubview(favoriteCollectionView)
        view.addSubview(headerTableTitle)
        view.addSubview(tableView)
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(FavoriteCollectionViewCell.self,
                                        forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
        favoriteCollectionView.showsHorizontalScrollIndicator = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationItem()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -32),
            headerStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 32),
            headerStack.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            favoriteCollectionView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 10),
            favoriteCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            favoriteCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteCollectionView.heightAnchor.constraint(equalToConstant: 160),
        ])
        
        NSLayoutConstraint.activate([
            headerTableTitle.topAnchor.constraint(equalTo: favoriteCollectionView.bottomAnchor, constant: 20),
            headerTableTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            headerTableTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerTableTitle.bottomAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -32),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 32)
        ])
    }
    
    private func setupNavigationItem() {
        let rightItem = UIBarButtonItem()
        let emptyItem = UIBarButtonItem()
        rightItem.image = .group
        navigationItem.title = "Favorite"
        navigationItem.rightBarButtonItems = [emptyItem, rightItem]
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        cell.configure(image: UIImage.add, label: "Podcast name", sublabel: "30 Eps")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as? FavoriteCollectionViewCell else { return UICollectionViewCell() }
        cell.configure()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 120
        let cellHeight = 160
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17.0 //отступы между ячейками
    }

}
