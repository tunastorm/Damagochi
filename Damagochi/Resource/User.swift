//
//  User.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import Foundation


struct User: Codable {
    var name: String
    var tamagochi: Int 
}


struct NowUser {
    static var user = DefaultData.user
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
    
    static var tamagochi: Int {
        get {
            return user.tamagochi
        }
        set {
            user.tamagochi = newValue
        }
    }
}
