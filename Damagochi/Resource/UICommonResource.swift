//
//  UIelement.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit


struct UIResource {
    static var damagochi = "다마고치"
    static var color = Color()
    static var image = Image()
    static var fontSize = FontSize()
}

struct Color {
    let background = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    let font = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    let border = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
}

struct Image {
    let eatRice = UIImage(systemName: "leaf.circle")
    let eatWater = UIImage(systemName: "drop.circle")
    let wrtieName = UIImage(systemName: "pencil")
    let changeDamagochi = UIImage(systemName: "moon.fill")
    let resetData = UIImage(systemName: "arrow.clockwise")
}

struct FontSize {
    let thin = 13
    let middle = 14
    let thick  = 15
}
