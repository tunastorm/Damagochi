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
        let settingTitle = ViewUIValue.settingView.navigationTitle
        if navigationItem.backButtonTitle != settingTitle {
            navigationItem.backButtonTitle = ""
        }
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
