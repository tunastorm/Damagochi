//
//  Tamagochi.swift
//  Tamagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit

struct Tamagochi: Codable {
    let id: Int
    var name: String = ""
    
    var height: Int = Int.random(in: 50...100)
    
    var weight: Int = Int.random(in: 100...150)
    
    var level: Int = NowUser.user.level
    
    var image: String
    
    var rice: Int = NowUser.user.rice
    
    var water: Int = NowUser.user.water
    
    init(id: Int) {
        self.id = id
        if id > 0 && id <= 3{
            self.name = NowTamagochi.nameList[id]
        }
        var user = NowUser.user
        
        var image = ""
        switch name {
        case "따끔따끔":
            image = "1-\(user.level)"
        case "방실방실":
            image = "2-\(user.level)"
        case "반짝반짝":
            image = "3-\(user.level)"
        default: print("Error")
        }
        self.image = image
    }
    
    mutating func setImage() {
        var user = NowUser.user
        
        if user.level >= 10 {
            return
        }
    
        switch name {
        case "따끔따끔":
            image = "1-\(user.level)"
        case "방실방실":
            image = "2-\(user.level)"
        case "반짝반짝":
            image = "3-\(user.level)"
        default: print("Error")
        }
    }
    
    mutating func setHeightWeight() {
        var user = NowUser.user
        if user.level >= 10 {
            return
        }
        height = height * user.level
        weight = weight * user.level
    }
}


struct NowTamagochi {
    static var Tamagochi = Tamagochi(id: 0)
    static var nameList: [String] = ["따끔따끔", "방실방실", "반짝반짝"]
}


struct TamagochiMessage {
    static var list: [String] = [
        "복습 아직 안 하셨다구요? 지금 잠이 오세여? userName님??",
        "userName님! 테이블뷰 컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요??",
        "userName님 오늘 깃허브 푸시 하셨어영?"
    ]
}
