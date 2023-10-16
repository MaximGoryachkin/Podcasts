//
//  Categories.swift
//  Podcasts
//
//  Created by Максим Горячкин on 09.10.2023.
//

import Foundation

enum Medium: String, CaseIterable {
    case tranding = "🔥Trending"
    case music
    case video
    case film
    case audiobook
    case newsletter
    case blog
    
    static func categories() -> [Medium] {
        Medium.allCases
    }
}
