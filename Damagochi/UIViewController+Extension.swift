//
//  UIViewController+Extension.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit

extension UIViewController {
    
    func setDefaultUI() {
        view.backgroundColor = UIValue.color.background
        setNavigationTitleColor(UIValue.color.font)
    }
    
    func setModalBackgroundUI() {
        view.backgroundColor = .black
        view.layer.opacity = UIValue.opacity.half
    }
    
    func setNavigationTitleColor(_ color: UIColor) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: color]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
