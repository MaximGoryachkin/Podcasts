//
//  Episode.swift
//  Podcasts
//
//  Created by Максим Горячкин on 27.09.2023.
//

import Foundation

// MARK: - Welcome
struct Episode: Codable {
    let status: String?
    let items: [EpisodeItems]?
    let count: Int?
    let query, description: String?
}

// MARK: - Item
struct EpisodeItems: Codable {
    let id: Int?
    let title: String?
    let link: String?
    let description, guid: String?
    let datePublished: Int?
    let datePublishedPretty: String?
    let dateCrawled: Int?
    let enclosureURL: String?
    let enclosureType: String?
    let enclosureLength, duration, explicit, episode: Int?
    let episodeType: String?
    let season: Int?
    let image: String?
    let feedItunesID: Int?
    let feedImage: String?
    let feedID: Int?
    let feedLanguage: String?
    let feedDead: Int?
}
