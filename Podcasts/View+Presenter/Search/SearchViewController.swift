//
//  SearchViewController.swift
//  Podcasts
//
//  Created by Miras Maratov on 28.09.2023.
//

import UIKit

class SearchViewController: UIViewController {
// MARK: - properties
    private let searchLabel: UILabel = {
        let element = UILabel()
        element.text = "Search"
        element.font = UIFont(name: "Manrope-Bold", size: 16)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let searchView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 12
        element.backgroundColor = #colorLiteral(red: 0.6557124077, green: 0.9678753018, blue: 0.9384237844, alpha: 1)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let textField: UITextField = {
        let element = UITextField()
        element.placeholder = "Podcast, chanel or artist"
        element.clearButtonMode = .whileEditing
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let loupe: UIImageView = {
        let element = UIImageView()
        element.backgroundColor = .clear
        element.image = UIImage(named: "search/inactive")
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
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
    
// MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        setUpViews()
    }
    
// MARK: - flow funcs
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
        searchView.addSubview(textField)
        searchView.addSubview(loupe)
        view.addSubview(searchLabel)
        view.addSubview(genresLabel)
        view.addSubview(seeAllButton)
        view.addSubview(browseLabel)
        setConstraints()
        seeAllButton.addTarget(self, action: #selector(goToResult), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            searchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchLabel.heightAnchor.constraint(equalToConstant: 22),
            
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            searchView.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 34),
            searchView.heightAnchor.constraint(equalToConstant: 48),
            
            loupe.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -24),
            loupe.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 12),
            loupe.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -12),
            loupe.widthAnchor.constraint(equalToConstant: 24),
            
            textField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 24),
            textField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 12),
            textField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -12),
            textField.trailingAnchor.constraint(equalTo: loupe.leadingAnchor, constant: -26),
            
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
    
//    @objc private func goToResult(){
//        let vc = ResultViewController()
//        vc.view.alpha = 0.0
//        addChild(vc)
//        vc.view.frame = self.view.bounds
//        self.view.addSubview(vc.view)
//        
//        UIView.animate(withDuration: 0.3) {
//            vc.view.alpha = 1.0
//        }
//        vc.didMove(toParent: self)
//    }
    
    //!!!: Maybe here's better solution to function above.
    @objc private func goToResult() {
        navigationController?.pushViewController(ResultViewController(), animated: true)
    }

}

// MARK: - extension
extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
