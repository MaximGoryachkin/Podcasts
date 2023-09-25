//
//  SearchPodcast.swift
//  Podcasts
//
//  Created by Максим Горячкин on 27.09.2023.
//

import Foundation

// MARK: - Welcome
struct SearchPodcast: Codable {
    let status: String?
    let feeds: [Feed]?
    let count: Int?
    let query, description: String?
}

enum ContentType: String, Codable {
    case applicationRSSXML = "application/rss+xml"
    case applicationRSSXMLCharsetUTF8 = "application/rss+xml; charset=UTF-8"
    case contentTypeApplicationRSSXMLCharsetUTF8 = "application/rss+xml; charset=utf-8"
    case empty = ""
}

enum Language: String, Codable {
    case enUS = "en-US"
    case enUs = "en-us"
}

enum Medium: String, Codable {
    case podcast = "podcast"
}
