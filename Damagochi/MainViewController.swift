//
//  MainViewController.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit

class MainViewController: UIViewController {
    
    var user: User?
    var data: Damagochi?

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
        if let userName = user?.name {
            navigationItem.title = userName + ViewUIValue.MainView.navigationTitle
        }
        setDefaultUI()
    }
    
    
}
