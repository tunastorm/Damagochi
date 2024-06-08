//
//  UIButton+Extension.swift
//  Damagochi
//
//  Created by 유철원 on 6/8/24.
//

import UIKit

extension UIButton {
    func setEatButtonUI() {
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
        self.layer.borderWidth = ViewUIValue.MainView.eatButtonBorderWidth
        self.layer.borderColor = UIValue.color.border
        self.layer.cornerRadius = ViewUIValue.MainView.eatButtonRadious
        self.titleLabel?.font = .boldSystemFont(ofSize: UIValue.fontSize.thin)
        self.titleLabel?.textColor = UIValue.color.font
        self.tintColor = UIValue.color.font
        self.setTitleColor(UIValue.color.font, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0,
                                                 bottom: 0, right: 10)
    }
}
