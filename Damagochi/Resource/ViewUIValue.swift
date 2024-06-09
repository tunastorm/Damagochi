//
//  UINumericalValue.swift
//  Tamagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit


struct ViewUIValue {
    static var selectView = SelectViewValue()
    static var selectViewCell = SelectViewCellValue()
    static var selectedItemView = SelectedItemViewVlaue()
    static var mainView = MainViewValue()
    static var settingView = SettingViewValue()
    static var settingViewCell = SettingViewCellValue()
    
    private init() { }
}

struct SelectViewValue {
    let navigationTitle = UIValue.Tamagochi + " 선택하기"
    let changeNavigationTitle = UIValue.Tamagochi + " 변경하기"
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
    let changeButtonTitle = "변경하기"
    let descriptionBase = ["저는 (fullname)입니당\n",
                           "키는 (height)Km, ",
                           "몸무게는 (weight)톤이에용\n성격은 화끈하고 날라다닙니당~!\n",
                           "열심히 잘 먹고 잘 클 자신이 있습니당!\n(name)!"]
    let descriptionRegx = ["(fullname)", "(height)", "(weight)", "(name)"]
}

struct MainViewValue {
    let navigationTitle =  "님의 " + UIValue.Tamagochi 
    let eatRiceButtonTitle = "밥먹기"
    let eatRicePlaceholder = "밥주세용"
    let eatWaterPlaceholder = "물주세용"
    let eatWaterButtonTitle = "물먹기"
    let coverViewCornerRadious = CGFloat(110)
    let eatButtonRadious = CGFloat(5)
    let eatButtonBorderWidth = CGFloat(1)
    let eatMinValue = 1
    let riceMax = 99
    let warterMax = 49
}

struct SettingViewValue {
    let navigationTitle = "설정"
    let numberOfRowsInSection = 3
}

struct SettingViewCellValue {
    let changeUserNameLabel = "내 이름 설정하기"
    let changeTamagochiLabel = "다마고치 변경하기"
    let resetAlertCancle = "취소"
    let resetAlertDelete = "삭제"
    let resetDataLabel = "데이터 초기화"
    let resetDataMessage = "정말 다시 처음부터 시작하실 건가용?"
}



