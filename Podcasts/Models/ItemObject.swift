//
//  ItemObject.swift
//  Podcasts
//
//  Created by Максим Горячкин on 13.10.2023.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var length: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var author: String = ""
}
