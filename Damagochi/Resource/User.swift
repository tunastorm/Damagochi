//
//  User.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import Foundation


struct User {
    let name: String
}


struct DummyUser {
    static var userList: [User] = [
        User(name: "대장")
    ]
}
