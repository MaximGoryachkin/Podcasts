//
//  ChannelViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 30.09.2023.
//

import UIKit

class ChannelViewController: UIViewController {

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
        view.text = "Baby Pesut Podcast"
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
        view.text = "56 Eps"
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
        view.text = "Dr. Oi om jean"
        view.textAlignment = .center
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
        view.addSubview(mainStackView)
        view.addSubview(tableView)
        view.backgroundColor = .white
        addSubviews(stack: mainStackView, views: imageView, mainTitle, subtitleStackView)
        addSubviews(stack: subtitleStackView, views: numberEpisodesLabel, separatorImage, autorNameLabel)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "ChannelTableViewCell")
        setupUI()
        navigationItem.title = "Channel"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Globals.changeLayer(of: imageView)
        tableView.visibleCells.forEach { cell in
            let newCell = cell as! TableViewCell
            newCell.updateLayer()
        }
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
    
}

extension ChannelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelTableViewCell", for: indexPath) as! TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "All Episodes"
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! TableViewCell
        cell.updateLayer()
    }
    
}
