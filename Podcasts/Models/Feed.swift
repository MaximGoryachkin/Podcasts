//
//  Feed.swift
//  Podcasts
//
//  Created by Максим Горячкин on 27.09.2023.
//

import Foundation

struct Feed: Codable {
    let author: String
    let categories: [String: String]
    let image: String?
    let title: String
    let url: String?
    let episodeCount: Int?
}
