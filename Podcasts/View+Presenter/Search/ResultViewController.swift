//
//  ResultViewController.swift
//  Podcasts
//
//  Created by Miras Maratov on 29.09.2023.
//

import UIKit

class ResultViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        hidesBottomBarWhenPushed = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
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
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = podcastTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
