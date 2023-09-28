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
        element.font = UIFont(name: "Manrope-Regular", size: 16)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let searchView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 12
        element.backgroundColor = .lightGray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let genresLabel: UILabel = {
        let element = UILabel()
        element.text = "Top genres"
        element.font = UIFont(name: "Manrope-Regular", size: 16)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let seeAllLabel: UILabel = {
        let element = UILabel()
        element.text = "See all"
        element.textColor = .lightGray
        element.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let genresTableView: UITableView = {
        let element = UITableView()
        element.backgroundColor = .lightGray
        element.alwaysBounceHorizontal = true
        element.alwaysBounceVertical = false
        element.separatorStyle = .none
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
// MARK: - life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
// MARK: - flow funcs
    private func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(searchView)
        view.addSubview(searchLabel)
        view.addSubview(genresLabel)
        view.addSubview(seeAllLabel)
        view.addSubview(genresTableView)
        setDelegate()
        genresTableView.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        setConstraints()
    }
    
    private func setDelegate() {
        genresTableView.delegate = self
        genresTableView.dataSource = self
        genresTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
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
            
            genresLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 198),
            genresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            genresLabel.heightAnchor.constraint(equalToConstant: 22),
            
            seeAllLabel.topAnchor.constraint(equalTo: genresLabel.topAnchor),
            seeAllLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            genresTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 231),
            genresTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            genresTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genresTableView.heightAnchor.constraint(equalToConstant: 84)
        ])
    }
}

// MARK: - extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = genresTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
