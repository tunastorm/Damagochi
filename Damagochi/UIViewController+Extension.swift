//
//  UIViewController+Extension.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit

extension UIViewController {
    func setNavigationTitleColor(_ color: UIColor) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: color]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
}
