//
//  UINumericalValue.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit





struct ViewUIValue {
    static var selectView = SelectViewValue()
    static var selectViewCell = SelectViewCellValue()
    static var selectedItemView = SelectedItemViewVlaue()
    static var MainView = MainViewValue()
}

struct SelectViewValue {
    let navigationTitle = UIValue.damagochi + " 선택하기"
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

struct SelectViewCellValue {
    let coverViewCornerRadius = CGFloat(50)
    let labelViewBorderWidth = CGFloat(1)
    let labelViewCornerRadius = CGFloat(5)
}

struct SelectedItemViewVlaue {
    let modalViewCornerRadious = CGFloat(20)
    let coverViewCornerRadious = CGFloat(57)
    let cancleButtonTitle = "취소"
    let startButtonTitle = "시작하기"
}

struct MainViewValue {
    let navigationTitle =  "님의 " + UIValue.damagochi 
    let eatRiceButtonTitle = "밥먹기"
    let eatRicePlaceholder = "밥주세용"
    let eatWaterPlaceholder = "물주세용"
    let eatWaterButtonTitle = "물먹기"
    let coverViewCornerRadious = CGFloat(110)
    let eatButtonRadious = CGFloat(5)
    let eatButtonBorderWidth = CGFloat(1)
}



