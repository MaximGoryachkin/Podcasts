//
//  PodcastType.swift
//  Podcasts
//
//  Created by Леонид Турко on 01.10.2023.
//

enum PodcastType: String, CaseIterable {
    case dessert
    case appetizer
    case salad
    case bread
    case breakfast
    case soup
    case beverage
    case sauce
    case fingerfood
    case snack
    
    var title: String {
        rawValue.capitalized
    }
}
