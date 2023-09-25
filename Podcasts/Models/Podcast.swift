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
    let query: Query?
    let feed: Feed?
    let description: String?
}


// MARK: - Query
struct Query: Codable {
    let id: String?
}
