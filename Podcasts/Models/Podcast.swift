//
//  Podcast.swift
//  Podcasts
//
//  Created by Максим Горячкин on 09.10.2023.
//

import Foundation

struct Podcast {
    let title: String
    let author: String
    let image: String
    let categories: [String: String]
    let episodeCount: Int
    let url: String
    var items: [Item]
}
