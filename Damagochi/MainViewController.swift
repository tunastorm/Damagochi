//
//  MainViewController.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
    }
}

extension MainViewController: CodeBaseUI {
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configUI() {
        navigationItem.title = DummyUser.userList[0].name + ViewUIValue.MainView.navigationTitle
        setDefaultUI()
    }
    
    
}
