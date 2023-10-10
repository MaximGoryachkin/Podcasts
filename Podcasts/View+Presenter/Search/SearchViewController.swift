//
//  SearchViewController.swift
//  Podcasts
//
//  Created by Miras Maratov on 28.09.2023.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITextFieldDelegate {
// MARK: - properties
    var searchInput: String = ""
    
    private let searchView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 16
        element.backgroundColor = .white
        element.layer.borderColor = UIColor.lightGray?.cgColor
        element.layer.borderWidth = 0.4
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let genresLabel: UILabel = {
        let element = UILabel()
        element.text = "Top genres"
        element.font = UIFont(name: "Manrope-Bold", size: 16)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let seeAllButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = .clear
        element.setTitle("See all", for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        element.setTitleColor(.darkGray, for: .normal)
        element.contentHorizontalAlignment = .right
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let browseLabel: UILabel = {
        let element = UILabel()
        element.text = "Browse all"
        element.font = UIFont(name: "Manrope-Bold", size: 16)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let genresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let element = UICollectionView(frame: .zero, collectionViewLayout: layout) // Указываем начальный frame
        element.backgroundColor = .clear
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let element = UICollectionView(frame: .zero, collectionViewLayout: layout)
        element.backgroundColor = .clear
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let searchBar: UISearchBar = {
        let element = UISearchBar()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let searchButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = .clear
        element.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        element.setImage(UIImage(named: "search/inactive"), for: .normal)
        element.addTarget(SearchViewController.self, action: #selector(searchButtontapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
//    private let customNavBar = UINavigationBar()
//    let searchController = UISearchController(searchResultsController: nil)
    
// MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
//        setUpSearchBar()
//        setCollection()
//        setUpViews()
//
//        NetworkManager.shared.fetchDataSearchPodcast(from: DataManager.shared.searchURL, with: {podcast in
//        })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpSearchBar()
        setCollection()
        setUpViews()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
// MARK: - flow funcs
    @objc func searchButtontapped() {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            searchButton.setImage(UIImage(named: "search/inactive"), for: .normal)
        }
    
//    private func setNavBar() {
//
//        // Создайте настраиваемый UINavigationItem
//        let navigationItem = UINavigationItem()
//        navigationItem.title = "Search"
//
//        // Создайте настраиваемую кнопку для навигационного бара (пример)
//
//        // Установите настраиваемый UINavigationItem для настраиваемого UINavigationBar
//        customNavBar.items = [navigationItem]
//
//        // Добавьте настраиваемый UINavigationBar на вершину контроллера
//        view.addSubview(customNavBar)
//        searchController.searchResultsUpdater = self
//        navigationItem.searchController = searchController
//
//        setupSearchBar()
//
//        // Настройте ограничения для настраиваемого UINavigationBar
//        customNavBar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
    
    private func setupNavBar() {
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 45, self.view.frame.size.width, 80))
        navigationBar.barTintColor = .white
        let navigationItem = UINavigationItem.init(title: "Search")
        navigationBar.items = [navigationItem]
        navigationBar.shadowImage = UIImage()
        
        view.addSubview(navigationBar)
    }
    
    private func setUpSearchBar() {
        let searchTextField = searchBar.searchTextField
        searchTextField.placeholder = "Podcast, channel, or artists"
        searchTextField.backgroundColor = .clear
        searchTextField.borderStyle = .none
        searchTextField.leftView = nil
        searchTextField.rightView = searchButton
        searchTextField.rightViewMode = .always
    }
    
    private func setCollection() {
        genresCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
        view.addSubview(genresCollectionView)
        genresCollectionView.showsHorizontalScrollIndicator = false
        
        verticalCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "VerticalCollectionViewCell")
        verticalCollectionView.delegate = self
        verticalCollectionView.dataSource = self
        view.addSubview(verticalCollectionView)
        verticalCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(searchView)
        searchView.addSubview(searchBar)
        view.addSubview(genresLabel)
        view.addSubview(seeAllButton)
        view.addSubview(browseLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 48),
            
            searchBar.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 12),
            searchBar.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -12),
            searchBar.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            
//            searchButton.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 12),
//            searchButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -12),
//            searchButton.heightAnchor.constraint(equalToConstant: 24),
//            searchButton.widthAnchor.constraint(equalToConstant: 24),
          
//            searchBar.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 24),
//            searchBar.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 12),
//            searchBar.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -12),
//            searchBar.trailingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: -26),
            
            genresLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 198),
            genresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            genresLabel.heightAnchor.constraint(equalToConstant: 22),
            
            seeAllButton.topAnchor.constraint(equalTo: genresLabel.topAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            seeAllButton.heightAnchor.constraint(equalToConstant: 24),
            seeAllButton.widthAnchor.constraint(equalToConstant: 49),
            
            genresCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 231),
            genresCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            genresCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genresCollectionView.heightAnchor.constraint(equalToConstant: 84),
            
            browseLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 339),
            browseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            browseLabel.heightAnchor.constraint(equalToConstant: 22),
            
            verticalCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 382),
            verticalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            verticalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            verticalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//        print(text)
//
//    }
        
    private func goToResult(){
        let vc = ResultViewController()
        vc.view.alpha = 0.0
        addChild(vc)
        vc.view.frame = self.view.bounds
        self.view.addSubview(vc.view)

        UIView.animate(withDuration: 0.3) {
            vc.view.alpha = 1.0
        }
        vc.didMove(toParent: self)
    }
    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        if searchBar.text != "" {
//           // goToResult()
//        navigationController?.pushViewController(ResultViewController(), animated: true)
//        } else {
//            searchBar.placeholder = "Type something"
//        }
//        searchBar.resignFirstResponder()
//    }
    
// MARK: - searchBar funcs
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchButton.setImage(UIImage(named: "search/inactive"), for: .normal)
        } else {
            searchButton.setImage(UIImage(named: "xmark"), for: .normal)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
              // goToResult()
            let vc = ResultViewController()
            vc.searchTerm = searchBar.text ?? ""
            navigationController?.pushViewController(vc, animated: true)
            searchBar.text = ""
            searchButton.setImage(UIImage(named: "search/inactive"), for: .normal)
           } else {
               searchBar.placeholder = "Type something"
           }
//        searchBar.resignFirstResponder()
        
        print("1")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - extension
extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genresCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
            cell.configure()
            return cell
        } else if collectionView == verticalCollectionView {
            // Иной идентификатор и настройку для вертикальной коллекции
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
            cell.configure()
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = Int((verticalCollectionView.frame.width - 17) / 2) // 17 - минимальный интервал между ячейками
        let cellHeight = 84
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17.0 //отступы между ячейками
    }
}
