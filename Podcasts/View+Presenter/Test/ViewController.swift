//
//  ViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 23.09.2023.
//

import UIKit

// Тестовый вью контроллер

var podcasts = [Item]()
var podcast: Item!
var xmlDict = [String: String]()
var xmlDictArr = [[String: String]]()
var currentElement = ""

let button = UIButton(type: .system)

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        view.addSubview(button)
        button.frame = view.bounds
        button.setTitle("Tap me", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
//        NetworkManager.shared.fetchDataPodcast(from: DataManager.shared.baseURL) { podcast in
//            self.fetchData(from: (podcast.feed?.url)!)
//        }
        NetworkManager.shared.fetchDataEpisode(from: DataManager.shared.episodeURL) { episode in
            print(episode.items?.first?.enclosureUrl)
        }
//        NetworkManager.shared.fetchDataSearchPodcast(from: DataManager.shared.searchURL) { podcast in
//            self.fetchData(from: (podcast.feeds?.first?.url)!)
//        }
    }
    
    func fetchData(from url: String) {
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
    
    @objc func buttonTapped() {
        podcasts.forEach {
            print($0.title)
        }
    }
    
}

extension ViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            xmlDict = [:]
            podcast = Item()
        } else {
            currentElement = elementName
        }
        if let url = attributeDict["url"], let length = attributeDict["length"] {
            podcast.url = url
            podcast.length = Int(length) ?? 0
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            xmlDictArr.append(xmlDict)
            podcast.description = String((xmlDict["description"]?.filter { $0 != "\"" }.split(separator: "\n").first)!)
            podcast.title = String((xmlDict["title"]?.filter { $0 != "\"" }.split(separator: "\n").first)!)
            podcasts.append(podcast)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if xmlDict[currentElement] == nil {
            xmlDict[currentElement] = ""
        }
        xmlDict[currentElement]! += string
    }
}
