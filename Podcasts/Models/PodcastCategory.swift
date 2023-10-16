//
//  Category.swift
//  Podcasts
//
//  Created by Максим Горячкин on 13.10.2023.
//

import Foundation

enum PodcastCategory: String, CaseIterable {
    case music = "Music & Fun"
    case art = "Arts & Fashion"
    case business = "Business"
    case games = "Games & Hobbies"
    case science = "Education & Science"
    case sport = "Sport"
    case news = "News"
    case mults = "Mults & TV"
    
    func allCategories() -> [PodcastCategory] {
        PodcastCategory.allCases
    }
}
