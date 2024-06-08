//
//  UIelement.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit


struct UIValue {
    static var damagochi = "다마고치"
    static var defaultMessage = "준비중이에요"
    static var numberOflineZero = 0
    static var color = Color()
    static var image = Image()
    static var opacity = Opacity()
    static var fontSize = FontSize()
    
    private init() { }
}

struct Color {
    let background = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    let font = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    let border = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
}

struct Image {
    let eatRice = UIImage(systemName: "leaf.circle")
    let eatWater = UIImage(systemName: "drop.circle")
    let writeName = UIImage(systemName: "pencil")
    let changeDamagochi = UIImage(systemName: "moon.fill")
    let resetData = UIImage(systemName: "arrow.clockwise")
    let defaultDamagochi = UIImage(named: "1-1")
    let bubble = UIImage(named: "bubble")
    let personCircle = UIImage(systemName: "person.circle")
}

struct Opacity {
    let full = Float(1.0)
    let half = Float(0.5)
    let clear = Float(0)
}

struct FontSize {
    let thin = CGFloat(13)
    let middle = CGFloat(14)
    let thick  = CGFloat(15)
}
