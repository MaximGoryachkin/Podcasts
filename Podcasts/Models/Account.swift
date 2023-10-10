//
//  Account.swift
//  Podcasts
//
//  Created by Максим Горячкин on 09.10.2023.
//

import Foundation
import RealmSwift

class Account: Object {
    @objc dynamic var avatar: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var dateOfBirth: Date = Date()
    @objc dynamic var gender: String = ""
}
