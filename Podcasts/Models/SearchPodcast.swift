//
//  SearchPodcast.swift
//  Podcasts
//
//  Created by Максим Горячкин on 27.09.2023.
//

import Foundation

struct SearchPodcast: Codable {
    let status: String?
    let feeds: [Feed]?
    let count: Int?
    let query, description: String?
}
