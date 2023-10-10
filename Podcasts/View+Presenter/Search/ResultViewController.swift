//
//  ResultViewController.swift
//  Podcasts
//
//  Created by Miras Maratov on 29.09.2023.
//

import UIKit

class ResultViewController: UIViewController, UISearchBarDelegate, UITextFieldDelegate {
// MARK: - arrays for cell
    var allNames = [
        "Between love and career",
        "The powerfull way to move on",
        "MOnkeys love make me curious",
        "How to beat your inner fear",
        "Who am I and what my purpose",
        "Why should you be baper",
        "Love and friends",
        "Comedy in stress life",
        "Work life balance",
        "Everyone is hero",
        "My first love",
    ]
    
    var infoArray = [
        "56:38 • 82 Eps",
        "24:40 • 40 Eps",
        "40:24 • 120 Eps",
        "24:38 • 21 Eps",
        "36:11 • 12 Eps",
        "14:34 • 24 Eps",
        "35:46 • 40 Eps",
        "43:34 • 12 Eps",
        "41:43 • 24 Eps",
        "34:12 • 24 Eps",
        "24:40 • 25 Eps",
    ]

// MARK: - properties
    var searchController: UISearchController?
    
    var searchTerm = ""
    
    private let resultLabel: UILabel = {
        let element = UILabel()
        element.text = "Search result"
        element.font = UIFont(name: "Manrope-Bold", size: 14)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let resultView: UIView = {
        let element = UIView()
        element.backgroundColor = .clear
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let avatarView: UIView = {
        let element = UIView()
        element.backgroundColor = .customLightBlue
        element.layer.cornerRadius = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let podcastName: UILabel = {
        let element = UILabel()
        element.text = "Baby Pesut podcast"
        element.font = UIFont(name: "Manrope-Bold", size: 16)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let shortInfo: UILabel = {
        let element = UILabel()
        element.text = "56 Eps | Dr.Oi om jean"
        element.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        element.textAlignment = .left
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let podcastLabel: UILabel = {
        let element = UILabel()
        element.text = "All podcast"
        element.font = UIFont(name: "Manrope-Regular", size: 14)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let podcastTableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.alwaysBounceVertical = true
        element.separatorStyle = .none
        return element
    }()
    
    private let searchView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 16
        element.backgroundColor = .white
        element.layer.borderColor = UIColor.lightGray?.cgColor
        element.layer.borderWidth = 0.4
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
        element.setImage(UIImage(named: "xmark"), for: .normal)
        element.addTarget(ResultViewController.self, action: #selector(searchButtontapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
// MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        hidesBottomBarWhenPushed = false
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillLayoutSubviews() {
        setUpSearchBar()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
// MARK: - flow funcs
    @objc func searchButtontapped() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpSearchBar() {
        let searchTextField = searchBar.searchTextField
        searchTextField.backgroundColor = .clear
        searchTextField.borderStyle = .none
        searchTextField.leftView = nil
        searchTextField.rightView = searchButton
        searchTextField.rightViewMode = .always
        searchBar.text = searchTerm
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(searchView)
        searchView.addSubview(searchBar)
        view.addSubview(resultLabel)
        view.addSubview(resultView)
        view.addSubview(podcastLabel)
        view.addSubview(podcastTableView)
        resultView.addSubview(avatarView)
        resultView.addSubview(podcastName)
        resultView.addSubview(shortInfo)
        setDelegate()
        setConstraints()
    }
    
    private func setDelegate() {
        podcastTableView.delegate = self
        podcastTableView.dataSource = self
        podcastTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        podcastTableView.showsVerticalScrollIndicator = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 48),
            
            searchBar.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 12),
            searchBar.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -12),
            searchBar.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 113),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            resultLabel.heightAnchor.constraint(equalToConstant: 21),
            
            resultView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            resultView.heightAnchor.constraint(equalToConstant: 56),
            //adding in resultView:
            avatarView.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 0),
            avatarView.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 0),
            avatarView.heightAnchor.constraint(equalToConstant: 56),
            avatarView.widthAnchor.constraint(equalToConstant: 56),
            
            podcastName.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 5),
            podcastName.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 20),
            podcastName.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -5),
            shortInfo.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -5),
            shortInfo.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 20),
            shortInfo.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -5),
            
            podcastLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
            podcastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            podcastLabel.heightAnchor.constraint(equalToConstant: 19),
            
            podcastTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 263),
            podcastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            podcastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            podcastTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - extension for protocol funcs
extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = podcastTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.reuseCell(name: allNames[indexPath.row], info: infoArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
