//
//  UIViewController+Extension.swift
//  Tamagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit

extension UIViewController {
    
    func setDefaultUI() {
        view.backgroundColor = UIValue.color.background
        setNavigationTitleColor(UIValue.color.font)
//        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.barTintColor = UIValue.color.font
    }
    
    func setModalBackgroundUI() {
        view.backgroundColor = .black
        view.layer.opacity = UIValue.opacity.half
    }
    
    func setNavigationTitleColor(_ color: UIColor) {
        self.navigationController?.navigationBar.tintColor = UIValue.color.font
        let textAttributes = [NSAttributedString.Key.foregroundColor: color]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func saveData(forUser: Bool, forTamagochi: Bool) {
        if forUser {
            UserDefaultsManager.nowUser = NowUser.user
        }
        
        if forTamagochi {
            UserDefaultsManager.nowTamagochi = NowTamagochi.tamagochi
        }
        
    }
}
