//
//  Podcast.swift
//  Podcasts
//
//  Created by Максим Горячкин on 26.09.2023.
//

import Foundation

import Foundation

// MARK: - Podcast
struct Podcast: Codable {
    let status: String?
    let feed: Feed?
    let description: String?
}

