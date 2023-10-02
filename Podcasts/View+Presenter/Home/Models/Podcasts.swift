//
//  Podcast.swift
//  Podcasts
//
//  Created by Максим Горячкин on 02.10.2023.
//

struct Podcast: Hashable {
  let podcastName: String
  let authorName: String
  let podcastType: String
  let episodeQty: String
}

struct PodcastList: Hashable {
  let all = [
  Podcast(podcastName: "Ngobam", authorName: "Gofar Hilman", podcastType: "Music & Fun", episodeQty: "23 Eps"),
  Podcast(podcastName: "Semprod", authorName: "Kuy Entertainment", podcastType: "Life & Chill", episodeQty: "44 Eps"),
  Podcast(podcastName: "Sruput Nendang", authorName: "Marco", podcastType: "Life & Chill", episodeQty: "46 Eps")
  ]
}
