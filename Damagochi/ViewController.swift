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
        rollbackData()
        updateData(forUser: true, forDamagochi: true)
        let userState = userChecker()
        switch userState {
        case .existDamagochi: goMainView()
        case .noDamagochi: goSelectView()
        case .noUser: print("[ErrorPoint] \(String(describing:self))-\(#function)")
        }
    }
    
    func updateData(forUser: Bool, forDamagochi: Bool) {
        if let nowUser = UserDefaultsManager.nowUser, forUser {
            NowUser.user = nowUser
            self.user = NowUser.user
        } else {
            UserDefaultsManager.nowUser = NowUser.user
            user = NowUser.user
        }
           
        if let damagochiList = UserDefaultsManager.damagochiList, let user, forDamagochi {
            DamagochiList.list = damagochiList
        } else {
            UserDefaultsManager.damagochiList = DamagochiList.list
        }
    }
    
    func userChecker() -> UserState {
        var userState = UserState.noUser
        if let user {
            switch user.damagochi {
            case 0: userState = UserState.noDamagochi
            case 1...3: userState = UserState.existDamagochi
            default: print("[ErrorPoint] \(String(describing:self))-\(#function)")
            }
        }
        
        return userState
    }
    
    func goSelectView() {
        let vc = SelectViewController()
//        vc.user = self.user
        navigationPresentAfterView(view: vc, style: .fullScreen, animated: false)
    }
    
    func goMainView() {
        let vc = MainViewController()
        if let id = user?.damagochi {
            print(#function, "DamagochiList.list: \(DamagochiList.list)")
//            vc.data = DamagochiList.list[id-1]
//            vc.user = self.user
            navigationPresentAfterView(view: vc, style: .fullScreen, animated: false)
        }
    }
    
    // 테스트용
    func rollbackData() {
        let userKey = UserDefaultsManager.userKey
        let dataKey = UserDefaultsManager.damagochiKey
        UserDefaultsManager.removeValue(userKey)
        UserDefaultsManager.removeValue(dataKey)
    }
}
