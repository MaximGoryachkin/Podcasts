//
//  HomeViewProtocol.swift
//  Podcasts
//
//  Created by Максим Горячкин on 09.10.2023.
//

import Foundation
import FirebaseAuth
import RealmSwift

class HomeViewPresenter {
    
    let realm = try! Realm()
    weak var delegate: HomeViewProtocol!
    var podcasts = [Podcast]()
    
    func fetchProfileData() {
        
    }
    
    func fetchDataForCategories() {
        NetworkManager.shared.fetchDataPodcast(from: DataManager.shared.trendingURL) { podcast in
            if let feeds = podcast.feeds {
                for feed in feeds {
                    guard let image = feed.image, let url = feed.url else { return }
                    
                    let podcast = Podcast(title: feed.title,
                                          author: feed.author,
                                          image: image,
                                          categories: feed.categories,
                                          episodeCount: feed.episodeCount ?? 0,
                                          url: url, 
                                          items: [])
                    self.podcasts.append(podcast)
                }
            }
            self.delegate.updateCategories(with: self.podcasts)
        }
        
    }
    
    func fetchPodcasts() {
        
    }
}
