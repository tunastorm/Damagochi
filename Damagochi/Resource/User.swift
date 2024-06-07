//
//  User.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import Foundation


struct User: Codable {
    var name: String
    var damagochi: Int
}


struct NowUser {
    var user: User = User(name: "대장", damagochi: 0)
    var now: User {
        get {
            return user
        }
        set {
            user = newValue
        }
    }
    var name: String {
        get {
            return user.name
        }
        set{
            user.name = newValue
        }
    }
    var damagochi: Int {
        get {
            return user.damagochi
        }
        set {
            user.damagochi = newValue
        }
        
    }
    //static var now: User = User(name: "대장", damagochi: 1)
}
