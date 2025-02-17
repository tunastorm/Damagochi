//
//  SceneDelegate.swift
//  Tamagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var user: User?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        var rootView = UIViewController()
        
        updateData(forUser: true, forTamagochi: true)
    
        let userState = userChecker()
        switch userState {
        case .existTamagochi: rootView = MainViewController()
        case .noTamagochi: rootView = SelectViewController()
        case .noUser: print("[ErrorPoint] \(String(describing:self))-\(#function)")
        }
        
        print(self.self, #function, rootView)
        let navigationController = UINavigationController(rootViewController: rootView)
        window?.rootViewController = navigationController// sb entrypoint
        window?.makeKeyAndVisible() // show the rootViewController to display
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
     
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
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
        print("[SceneDelegate]",#function, NowUser.user)
        print("[SceneDelegate]",#function, NowTamagochi.tamagochi)
    }
    
    func userChecker() -> UserState {
        print("SceneDelegate", #function, user)
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

}

