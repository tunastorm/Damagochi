//
//  UINumericalValue.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit





struct UIViewResource {
    static var selectView = SelectViewValue()
    
}

struct SelectViewValue {
    let navigationTitle = UIResource.damagochi + " 선택하기"
    let defaultItemSize = 20
    let layoutMinLineSpacing = CGFloat(0)
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let itemsPerRow = CGFloat(3)
    let itemsPerColumn = ceil(CGFloat(5))
    let widthPadding: CGFloat
    let heightPadding: CGFloat
    
    init() {
        self.widthPadding = sectionInsets.left * (itemsPerRow + 1)
        self.heightPadding = sectionInsets.top * (itemsPerColumn + 1)
    }
}



