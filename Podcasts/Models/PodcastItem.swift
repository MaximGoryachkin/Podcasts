//
//  Title.swift
//  Podcasts
//
//  Created by Максим Горячкин on 26.09.2023.
//

import Foundation

struct PodcastItem: Hashable {
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var length: Int = 0
}
