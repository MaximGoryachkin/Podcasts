//
//  PodcastAPI.swift
//  Podcasts
//
//  Created by Максим Горячкин on 02.10.2023.
//

import Foundation

// MARK: - Podcast
struct PodcastAPI: Codable {
    let status: String?
    let feed: Feed?
    let description: String?
}
