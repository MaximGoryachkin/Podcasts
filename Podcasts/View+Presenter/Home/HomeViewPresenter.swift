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
    var categoiesPodcasts = [Podcast]()
    var podcastCategories = [CategoryItem]()
    
    func fetchProfileData() {
        
    }
    
    func fetchDataForCategories() {
        podcasts = []
        NetworkManager.shared.fetchDataPodcast(from: DataManager.shared.categoriesURL) { podcast in
            if let feeds = podcast.feeds {
                for feed in feeds {
                    guard let image = feed.image, let url = feed.url else { return }
                    
                    let podcast = Podcast(title: feed.title,
                                          author: feed.author,
                                          image: image,
                                          categories: feed.categories ?? ["":""],
                                          episodeCount: feed.episodeCount ?? 0,
                                          url: url,
                                          items: [])
                    self.podcasts.append(podcast)
                }
            }
            self.delegate.updateCategories(with: self.podcasts)
        }
    }
    
    func fetchPodcastsCategories() {
        let group = DispatchGroup()
        for category in PodcastCategory.allCases {
            group.enter()
            NetworkManager.shared.fetchDataPodcast(from: DataManager.shared.setCategory(with: category)) { podcast in
                self.categoiesPodcasts = []
                
                if let feeds = podcast.feeds {
                    for feed in feeds {
                        guard let image = feed.image, let url = feed.url else { return }
                        
                        let podcast = Podcast(title: feed.title,
                                              author: feed.author,
                                              image: image,
                                              categories: feed.categories ?? ["":""],
                                              episodeCount: feed.episodeCount ?? 0,
                                              url: url,
                                              items: [])
                        self.categoiesPodcasts.append(podcast)
                    }
                }
                let podcastCategory = CategoryItem(category: category, podcasts: self.categoiesPodcasts)
                self.podcastCategories.append(podcastCategory)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print("startUpdate")
            self.delegate.updatePodcastCategories(with: self.podcastCategories)
        }
    }

}

