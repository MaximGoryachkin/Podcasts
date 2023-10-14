//
//  HomeViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 01.10.2023.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func updateProfileInfo(with account: Account)
    func updateCategories(with podcasts: [Podcast])
    func updatePodcasts()
    func updatePodcastCategories(with podcastCategories: [CategoryItem])
    func prepareNavigation(with controller: UIViewController)
}

class HomeViewController: UIViewController {
    
    //MARK: Properties
    
    var presenter: HomeViewPresenter!
    var podcasts = [Podcast]()
    var podcastCategories = [CategoryItem]()
    
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
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        presenter = HomeViewPresenter()
        presenter.delegate = self
        presenter.fetchProfileData()
        
        DispatchQueue.global().async {
            self.presenter.fetchDataForCategories()
            self.presenter.fetchPodcastsCategories()
        }
        
        
        addSubviews(subviews: topStack, headerStack, mainCollectionView)
        addSubviews(to: topStack, subviews: avatarTitleStack, avatarImage)
        addSubviews(to: avatarTitleStack, subviews: avatarName, avatarStatus)
        addSubviews(to: headerStack, subviews: headerStackTitle, allButton)
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(HomeCollectionViewCell.self,
                                    forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        mainCollectionView.register(CategoryContainerViewCell.self,
                                    forCellWithReuseIdentifier: CategoryContainerViewCell.identifier)
        mainCollectionView.register(PopularContainerViewCell.self,
                                    forCellWithReuseIdentifier: PopularContainerViewCell.identifier)
        mainCollectionView.showsHorizontalScrollIndicator = false
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: Private methods
    
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
            mainCollectionView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 10),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            avatarImage.heightAnchor.constraint(equalToConstant: 52),
            avatarImage.widthAnchor.constraint(equalToConstant: 52)
        ])
    }
    
}

// MARK: CollectionView Delegate and DataSource methods

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        podcasts.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryContainerViewCell.identifier, for: indexPath) as? CategoryContainerViewCell else { return UICollectionViewCell() }
            cell.podcastCategories = podcastCategories
            cell.delegate = self
            cell.updateData()
            return cell
        } else if indexPath.row == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularContainerViewCell.identifier, for: indexPath) as? PopularContainerViewCell else { return UICollectionViewCell() }
            cell.delegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: podcasts[indexPath.row - 2])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 200)
        } else if indexPath.row == 1 {
            return CGSize(width: UIScreen.main.bounds.width, height: 44)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 64, height: 72)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let channelVC = ChannelViewController()
        channelVC.podcast = podcasts[indexPath.row - 2]
        print(podcasts[indexPath.row - 2].url)
        navigationController?.pushViewController(channelVC, animated: true)
    }
}

extension HomeViewController: HomeViewProtocol {
    func prepareNavigation(with controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func updateCategories(with podcasts: [Podcast]) {
        DispatchQueue.main.async {
            self.podcasts = podcasts
            self.mainCollectionView.reloadData()
        }
    }
    
    func updatePodcasts() {
        podcasts = []
        mainCollectionView.reloadData()
        presenter.fetchDataForCategories()
    }
    
    
    func updateProfileInfo(with account: Account) {
        
    }
    
    func updatePodcastCategories(with podcastCategories: [CategoryItem]) {
        DispatchQueue.main.async {
            self.podcastCategories = podcastCategories
            self.mainCollectionView.reloadData()
        }
        for category in podcastCategories {
            category.podcasts.forEach {
                print($0)
            }
        }
    }
}

