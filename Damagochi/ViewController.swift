//
//  ViewController.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit


// SelectView와 MainView 분기처리
class ViewController: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userState = userChecker()
        switch userState {
        case .existDamagochi: goMainView()
        case .noDamagochi: goSelectView()
        case .noUser: print("[ErrorPoint] \(String(describing:self))-\(#function)")
        }
    }
    
    func userChecker() -> UserState {
        var userState = UserState.noUser
        if let nowUser = UserDefaultsManager.nowUser {
            NowUser.user = nowUser
            user = NowUser.user
            switch nowUser.damagochi {
            case 0: userState = UserState.noDamagochi
            case 1...3: userState = UserState.existDamagochi
            default: print("[ErrorPoint] \(String(describing:self))-\(#function)")
            }
        } else {
            UserDefaultsManager.nowUser = NowUser.user
            guard let user = UserDefaultsManager.nowUser else { return UserState.noUser }
            NowUser.user = user
            userState = UserState.noDamagochi
        }
        return userState
    }
    
    func goSelectView() {
        let vc = SelectViewController()
        vc.user = self.user
        navigationPresentAfterView(view: vc, style: .fullScreen, animated: false)
    }
    
    func goMainView() {
        let vc = MainViewController()
        if let list = UserDefaultsManager.damagochiList, let id = user?.damagochi  {
            let damagochi = list[id-1]
            vc.data = damagochi
        }
        vc.user = self.user
        navigationPresentAfterView(view: vc, style: .fullScreen, animated: false)
    }
}
