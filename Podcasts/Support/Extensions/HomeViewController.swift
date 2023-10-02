//
//  HomeViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 01.10.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var topStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalCentering
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatarImage: UIImageView = {
        let view = UIImageView()
        view.image = .actions
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatarTitleStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatarName: UILabel = {
        let view = UILabel()
        view.font = .manropeBold16
        view.text = "Abigael Amaniah"
        return view
    }()
    
    private lazy var avatarStatus: UILabel = {
        let view = UILabel()
        view.font = .manropeRegular14
        view.text = "Love,life and chill"
        return view
    }()
    
    private lazy var headerStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerStackTitle: UILabel = {
        let view = UILabel()
        view.text = "Category"
        view.font = .manropeBold16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var allButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("See all", for: .normal)
        view.titleLabel?.font = .manropeRegular16
        view.setTitleColor(.systemGray, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
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
        addSubviews(subviews: topStack, headerStack, categoryCollectionView, popularCollectionView, tableView)
        addSubviews(to: topStack, subviews: avatarTitleStack, avatarImage)
        addSubviews(to: avatarTitleStack, subviews: avatarName, avatarStatus)
        addSubviews(to: headerStack, subviews: headerStackTitle, allButton)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCollectionViewCell.self,
                                        forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        categoryCollectionView.showsHorizontalScrollIndicator = false
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.register(PopularCollectionViewCell.self,
                                        forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        popularCollectionView.showsHorizontalScrollIndicator = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.register(AddPlaylistTableViewCell.self, forCellReuseIdentifier: AddPlaylistTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    private func addSubviews(subviews: UIView...) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    private func addSubviews(to stack: UIStackView, subviews: UIView...) {
        for subview in subviews {
            stack.addArrangedSubview(subview)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -32),
            topStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 32),
            topStack.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 20),
            headerStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -32),
            headerStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 32),
            headerStack.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            popularCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20),
            popularCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            popularCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularCollectionView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: popularCollectionView.bottomAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -32),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 32)
        ])
        
        NSLayoutConstraint.activate([
            avatarImage.heightAnchor.constraint(equalToConstant: 52),
            avatarImage.widthAnchor.constraint(equalToConstant: 52)
        ])
    }
        
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPlaylistTableViewCell.identifier, for: indexPath) as! AddPlaylistTableViewCell
            cell.configure(image: .add, label: "Create Playlist")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
            cell.configure(image: UIImage.add, label: "Podcast name", sublabel: "30 Eps")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.configure()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as? PopularCollectionViewCell else { return UICollectionViewCell() }
            cell.configure()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: 144, height: 200)
        } else {
            return CGSize(width: 120, height: 44)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17.0 //отступы между ячейками
    }
    
}
