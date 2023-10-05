//
//  Feed.swift
//  Podcasts
//
//  Created by Максим Горячкин on 27.09.2023.
//

import Foundation

struct Feed: Codable {
    let artwork: String
    let author: String
    let categories: [String: String]
    let description: String
    let id: Int
    let image: String
    let title: String
    let trendScore: Int
    let url: String?
}
