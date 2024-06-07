//
//  ViewController.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit


// SelectView와 MainView 분기처리
class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationPresentAfterView(view: SelectViewController(), style: .fullScreen, animated: false)
    }
}
