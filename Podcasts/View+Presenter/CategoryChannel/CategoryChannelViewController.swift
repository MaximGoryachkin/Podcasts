//
//  CategoryChannelViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 14.10.2023.
//

import UIKit

class CategoryChannelViewController: UIViewController {
    
    var category: CategoryItem!
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "test")
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainTitle: UILabel = {
        let view = UILabel()
        view.font = .manropeBold16
        view.text = ""
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var subtitleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .equalSpacing
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var numberEpisodesLabel: UILabel = {
        let view = UILabel()
        view.font = .manropeRegular14
        view.text = "0"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorImage: UIImageView = {
        let view = UIImageView()
        view.image = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var autorNameLabel: UILabel = {
        let view = UILabel()
        view.font = .manropeRegular14
        view.text = ""
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
        view.addSubview(tableView)
        view.backgroundColor = .white
        addSubviews(stack: mainStackView, views: imageView, mainTitle, subtitleStackView)
        addSubviews(stack: subtitleStackView, views: numberEpisodesLabel, separatorImage, autorNameLabel)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryChannelTableViewCell.self, forCellReuseIdentifier: CategoryChannelTableViewCell.identifier)
        navigationItem.title = "Channel"
        setupUI()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    private func addSubviews(stack: UIStackView, views: UIView...) {
        for view in views {
            stack.addArrangedSubview(view)
        }
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 85),
            imageView.widthAnchor.constraint(equalToConstant: 85),
            
            separatorImage.heightAnchor.constraint(equalToConstant: 19),
            separatorImage.widthAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)
        ])
    }
    
    private func updateUI() {
        mainTitle.text = category.category.rawValue
        autorNameLabel.text = String(category.podcasts.count)
    }
}

extension CategoryChannelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        category.podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryChannelTableViewCell.identifier, for: indexPath) as! CategoryChannelTableViewCell
        cell.configure(with: category.podcasts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "All Episodes"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelVC = ChannelViewController()
        channelVC.podcast = category.podcasts[indexPath.row]
        navigationController?.pushViewController(channelVC, animated: true)
    }
    
}
