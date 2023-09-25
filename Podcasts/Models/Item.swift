//
//  Title.swift
//  Podcasts
//
//  Created by Максим Горячкин on 26.09.2023.
//

import Foundation

struct Item {
    let title: String
    let description: String
    let enclosure: Enclosure
}

struct Enclosure {
    let url: String
}
