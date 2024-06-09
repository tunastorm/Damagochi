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
        self.navigationController?.navigationBar.tintColor = UIValue.color.font
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIValue.color.font]
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIValue.color.background
        appearance.shadowImage = nil
        appearance.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    private func colorToImage(_ color: UIColor) -> UIImage {
      let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
      let image: UIImage = UIGraphicsImageRenderer(size: size).image { context in
      color.setFill()
      context.fill(CGRect(origin: .zero, size: size))
      }
    return image
    }
    
    
    func setModalBackgroundUI() {
        view.backgroundColor = .black
        view.layer.opacity = UIValue.opacity.half
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
