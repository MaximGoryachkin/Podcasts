//
//  Feed.swift
//  Podcasts
//
//  Created by Максим Горячкин on 27.09.2023.
//

import Foundation

// MARK: - Feed
struct Feed: Codable {
    let id: Int?
    let podcastGUID, medium, title: String?
    let url, originalURL, link: String?
    let description, author, ownerName: String?
    let image, artwork: String?
    let lastUpdateTime, lastCrawlTime, lastParseTime, lastGoodHTTPStatusTime: Int?
    let lastHTTPStatus: Int?
    let contentType: String?
    let itunesID: Int?
    let itunesType, generator, language: String?
    let explicit: Bool?
    let type, dead: Int?
    let chash: String?
    let episodeCount, crawlErrors, parseErrors: Int?
    let categories: [String: String]?
    let locked, imageURLHash: Int?
}
