//
//  ViewController.swift
//  Podcasts
//
//  Created by Максим Горячкин on 23.09.2023.
//

import UIKit

// Тестовый вью контроллер

var titles = [String]()

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        
//        NetworkManager.shared.fetchDataPodcast(from: DataManager.shared.baseURL) { podcast in
//            self.fetchData(from: (podcast.feed?.url)!)
//        }
//        NetworkManager.shared.fetchDataEpisode(from: DataManager.shared.episodeURL) { episode in
//            print(episode.items?.first?.enclosureURL)
//        }
        NetworkManager.shared.fetchDataSearchPodcast(from: DataManager.shared.searchURL) { podcast in
            self.fetchData(from: (podcast.feeds?.first?.url)!)
        }
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
    
}

extension ViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        for (attr_key, attr_val) in attributeDict {
            print("Key: \(attr_key), value: \(attr_val)")
        }
    }
}
