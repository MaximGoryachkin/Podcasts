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
}

// MARK: - Item
struct EpisodeItems: Codable {
    let id: Int?
    let title: String?
    let link: String?
    let description: String?
    let datePublished: Int?
    let datePublishedPretty: String?
    let dateCrawled: Int?
    let enclosureUrl: String?
    let enclosureLength: Int?
    let feedImage: String?
    let feedLanguage: String?
}
