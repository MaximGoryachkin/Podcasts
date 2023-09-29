//
//  UIImage+TabBar.swift
//  Podcasts
//
//  Created by Максим Горячкин on 23.09.2023.
//

import UIKit.UIImage

extension UIImage {
    static let homeActive = UIImage(named: "home/active")
    static let homeInactive = UIImage(named: "home/inactive")
    
    static let searchActive = UIImage(named: "search/active")
    static let searchInactive = UIImage(named: "search/inactive")
    
    static let bookmarkActive = UIImage(named: "bookmark/active")
    static let bookmarkInactive = UIImage(named: "bookmark/inactive")
    
    static let settingsActive = UIImage(named: "settings/active")
    static let settingsInactive = UIImage(named: "settings/inactive")
    
    static let profile = UIImage(named: "profile")
    static let shield = UIImage(named: "shield")
    static let lock = UIImage(named: "lock")
    static let folder = UIImage(named: "folder")
    
    static let shuffle = UIImage(systemName: "shuffle")
    static let backward = UIImage(systemName: "backward.end.fill")
    static let forward = UIImage(systemName: "forward.end.fill")
    static let repeatImage = UIImage(systemName: "repeat")
    static let play = UIImage(systemName: "play.circle.fill")
}

