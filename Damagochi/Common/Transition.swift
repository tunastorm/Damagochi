//
//  ViewTransition.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit


protocol ViewTransition {
   
   func pushAfterView(view: UIViewController, animated: Bool)
    
   func presentAfterView(view: UIViewController, animated: Bool)
    
   func navigationPresentAfterView(view: UIViewController, style: UIModalPresentationStyle, animated: Bool)
    
   func popBeforeView(animated: Bool)
    
}

// 제네릭, 프로토콜
// some -> Opaque Type, any -> Existential Type
// WWDC

extension UIViewController: ViewTransition {

    func pushAfterView(view: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(view, animated: animated)
    }
    
    func presentAfterView(view: UIViewController, animated: Bool) {
        self.present(view, animated: animated)
    }
    
    func navigationPresentAfterView(view: UIViewController, style: UIModalPresentationStyle, animated: Bool) {
        let nav = UINavigationController(rootViewController: view)
        nav.modalPresentationStyle = style
        present(nav, animated: animated)
    }
    
    func popBeforeView(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}

protocol CellTransitionDelegate {

    func turnBackRootView()
    
    func pushChangeSelectView()
    
    func presentAlert(_ alert: UIAlertController, animated: Bool)
    
}


protocol DataReceiveDelegate {
    func receiveData<T>(data: T)
}

