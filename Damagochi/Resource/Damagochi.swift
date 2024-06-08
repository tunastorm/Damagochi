//
//  Damagochi.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit

struct Damagochi: Codable {
    let id: Int
    let name: String
    
    var height: Int = Int.random(in: 50...100)
    
    var weight: Int = Int.random(in: 100...150)
    
    var level: Int = 1 {
        didSet {
            setImage()
        }
    }
    
    var rice: Int = 0 {
        didSet {
            calculateLevel()
        }
    }
    var water: Int = 0 {
        didSet {
            calculateLevel()
        }
    }
    
    var image: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        
        var image = ""
        switch name {
        case "따끔따끔":
            image = "1-\(level)"
        case "방실방실":
            image = "2-\(level)"
        case "반짝반짝":
            image = "3-\(level)"
        default: print("Error")
        }
        self.image = image
    }
    
    mutating func calculateLevel() {
        if level >= 10 {
            return
        }
        
        let exp = (rice/5) + (water/2)
        print(#function, "exp: \(exp)" )
        var newlevel = level
        switch exp {
        case 20..<30: level = 2
        case 30..<40: level = 3
        case 40..<50: level = 4
        case 50..<60: level = 5
        case 60..<70: level = 6
        case 70..<80: level = 7
        case 80..<90: level = 8
        case 90..<100: level = 9
        case 100...: level = 10
        default: return
        }
    }
    
    mutating func setImage() {
        if level >= 10 {
            return
        }
    
        switch name {
        case "따끔따끔":
            image = "1-\(level)"
        case "방실방실":
            image = "2-\(level)"
        case "반짝반짝":
            image = "3-\(level)"
        default: print("Error")
        }
    }
    
    mutating func setHeightWeight() {
        if level >= 10 {
            return
        }
        height = height * level
        weight = weight * level
    }
}


struct DamagochiList {
    static var list: [Damagochi] = [
        Damagochi(id: 1, name: "따끔따끔"),
        Damagochi(id: 2, name: "방실방실"),
        Damagochi(id: 3, name: "반짝반짝"),
    ]
}


struct damagochiMessage {
    static var list: [String] = [
        "복습 아직 안 하셨다구요? 지금 잠이 오세여? userName님??",
        "userName님! 테이블뷰 컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요??",
        "userName님 오늘 깃허브 푸시 하셨어영?"
    ]
}
