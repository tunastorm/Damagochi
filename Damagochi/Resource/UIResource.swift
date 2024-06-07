//
//  UIelement.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit


struct UIResource {
    static var color = Color()
    static var image = Image()
    static var fontSize = FontSize()
}


struct Color {
    var background = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    var font = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    var border = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
}

struct Image {
    var eatRice = UIImage(systemName: "leaf.circle")
    var eatWater = UIImage(systemName: "drop.circle")
    var wrtieName = UIImage(systemName: "pencil")
    var changeDamagochi = UIImage(systemName: "moon.fill")
    var resetData = UIImage(systemName: "arrow.clockwise")
}

struct FontSize {
    var thin = 13
    var middle = 14
    var thick  = 15
}
