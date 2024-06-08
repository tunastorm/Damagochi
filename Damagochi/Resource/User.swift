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
    static var user = User(name: "대장", damagochi: 0)
    static var now: User {
        get {
            return user
        }
        set {
            user = newValue
        }
    }
    static var name: String {
        get {
            return user.name
        }
        set{
            user.name = newValue
        }
    }
    
    static var damagochi: Int {
        get {
            return user.damagochi
        }
        set {
           
            user.damagochi = newValue
        }
    }
    
}
