//
//  ViewController.swift
//  Tamagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit


// SelectView와 MainView 분기처리
class ViewController: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData(forUser: true, forTamagochi: true)
        let userState = userChecker()
        switch userState {
        case .existTamagochi: goMainView()
        case .noTamagochi: goSelectView()
        case .noUser: print("[ErrorPoint] \(String(describing:self))-\(#function)")
        }
    }
    
    func updateData(forUser: Bool, forTamagochi: Bool) {
        if let nowUser = UserDefaultsManager.nowUser, forUser {
            NowUser.user = nowUser
            self.user = NowUser.user
        } else {
            UserDefaultsManager.nowUser = NowUser.user
            user = NowUser.user
        }
           
        if let nowTamagochi = UserDefaultsManager.nowTamagochi, let user, forTamagochi {
            NowTamagochi.tamagochi = nowTamagochi
        } else {
            UserDefaultsManager.nowTamagochi = NowTamagochi.tamagochi
        }
        print(#function, NowUser.user)
        print(#function, NowTamagochi.tamagochi)
    }
    
    func userChecker() -> UserState {
        var userState = UserState.noUser
        if let user {
            switch user.tamagochi {
            case 0: userState = UserState.noTamagochi
            case 1...3: userState = UserState.existTamagochi
            default: print("[ErrorPoint] \(String(describing:self))-\(#function)")
            }
        }
        
        return userState
    }
    
    func goSelectView() {
//        pushAfterView(view: SelectViewController(), animated: false)
        navigationPresentAfterView(view: SelectViewController(),
                                   style: .fullScreen,
                                   animated: false)
    }
    
    func goMainView() {
        pushAfterView(view: MainViewController(), animated: false)
        navigationPresentAfterView(view: MainViewController(),
                                   style: .fullScreen,
                                   animated: false)
    }
}
