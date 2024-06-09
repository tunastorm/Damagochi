//
//  Tamagochi.swift
//  Tamagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit

struct Tamagochi: Codable {
    var id: Int
    var name: String = ""
    
    var height: Int = Int.random(in: 50...100)
    
    var weight: Int = Int.random(in: 100...150)
    
    var level: Int = 1 {
        didSet {
            setImage(false)
        }
    }
    
    var image: String = "1-1"
    
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
    
    init(id: Int) {
        self.id = id
        if id > 0 && id <= NowTamagochi.nameList.count {
            self.name = NowTamagochi.nameList[id]
            self.image = "\(id)-\(level)"
        }
    }
    mutating func setId(_ newId: Int) {
        id = newId
    }
    
    mutating func setName(_ newName: String) {
        name = newName
    }
    
    mutating func calculateLevel() {
        if level >= 10 {
            return
        }
        
        let exp = (rice/5) + (water/2)
        print(#function, "exp: \(exp)" )
    
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
    
    mutating func setImage(_ isChangeView: Bool) {
        var imgLevel = level
        if level >= 10 && !isChangeView {
            return
        } else if level >= 10 && isChangeView {
            imgLevel = 9
        }
        self.image = "\(id)-\(imgLevel)"
    }
    
    mutating func setHeightWeight() {
        if level >= 10 {
            return
        }
        height = height * level
        weight = weight * level
    }
}


struct NowTamagochi {
    static var tamagochi = DefaultData.tamagochi
    static var nameList = ["따끔따끔", "방실방실", "반짝반짝"]
//    static var tamagochiList: [String] = [
//        Tamagochi(id:1), Tamagochi(id:2), Tamagochi(id: 3)
//    ]
}


struct TamagochiMessage {
    static var list: [String] = [
        "복습 아직 안 하셨다구요? 지금 잠이 오세여? userName님??",
        "userName님! 테이블뷰 컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요??",
        "userName님 오늘 깃허브 푸시 하셨어영?"
    ]
}
