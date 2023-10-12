//
//  ChannelViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 30.09.2023.
//

import UIKit
import Kingfisher

class ChannelViewController: UIViewController {
    
    var podcast: Podcast!
    var items = [Item]()
    var item = Item()
    var xmlDict = [String: String]()
    var xmlDictArr = [[String: String]]()
    var currentElement = ""
    
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
        tableView.register(ChannelTableViewCell.self, forCellReuseIdentifier: ChannelTableViewCell.identifier)
        navigationItem.title = "Channel"
        setupUI()
        updateUI()
        fetchData(from: podcast.url)
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
    
    private func fetchData(from url: String) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("dataTaskWithRequest error: \(error)")
            }
            guard let data = data else { return }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }.resume()
    }
    
    private func updateUI() {
        let url = URL(string: podcast.image)
        imageView.kf.setImage(with: url)
        mainTitle.text = podcast.title
        autorNameLabel.text = podcast.author
    }
}

extension ChannelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCell.identifier, for: indexPath) as! ChannelTableViewCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "All Episodes"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerVC = PlayerViewController()
        playerVC.items = items
        playerVC.indexPath = indexPath
        navigationController?.pushViewController(playerVC, animated: true)
    }
    
}

extension ChannelViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            xmlDict = [:]
            item = Item()
        } else {
            currentElement = elementName
        }
        if let url = attributeDict["url"] {
            item.url = url
        }
        if let length = attributeDict["length"] {
            item.length = Int(length) ?? 0
        }
        if let imageURL = attributeDict["href"] {
            item.image = imageURL
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            xmlDictArr.append(xmlDict)
            if let description = xmlDict["description"]?.filter({ $0 != "\"" }).split(separator: "\n").first {
                item.description = String(description)
            }
            item.title = String((xmlDict["title"]?.filter { $0 != "\"" }.split(separator: "\n").first)!)
            item.author = podcast.author
            items.append(item)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if xmlDict[currentElement] == nil {
            xmlDict[currentElement] = ""
        }
        xmlDict[currentElement]! += string
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.numberEpisodesLabel.text = String(self.items.count)
        }
    }
}
