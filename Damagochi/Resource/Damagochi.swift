//
//  Damagochi.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit

struct Damagochi {
    var name: String
    
    var level: Int = 1 {
        didSet {
            setImage()
        }
    }
    
    var rice: Int = 0{
        didSet {
            calculateLevel()
        }
    }
    var water: Int = 0{
        didSet {
            calculateLevel()
        }
    }
    
    var image: String
    
    init(name:String) {
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
        let newlevel = (rice/5) + (water/2)
        if Int(newlevel) > level {
            level = newlevel
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
}


struct Dummy {
    static var dummyList: [Damagochi] = [
        Damagochi(name: "따끔따끔"),
        Damagochi(name: "방실방실"),
        Damagochi(name: "반짝반짝")
    ]
}
