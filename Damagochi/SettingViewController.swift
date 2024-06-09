//
//  SettingViewController.swift
//  Tamagochi
//
//  Created by 유철원 on 6/8/24.
//

import UIKit
import SnapKit
import Then

class SettingViewController: UIViewController {
     
    var delegate: ViewTransition?
    
    var user: User?
    var data: Tamagochi?
    
    let tableView = UITableView().then {
        $0.separatorInset = .zero
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData(forUser: true, forTamagochi: true)
        configBaseSetting()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    func updateData(forUser: Bool, forTamagochi: Bool) {
        if let nowUser = UserDefaultsManager.nowUser, forUser {
            NowUser.user = nowUser
            self.user = NowUser.user
        }
           
        if let nowTamagochi = UserDefaultsManager.nowTamagochi, let user, forTamagochi {
            NowTamagochi.tamagochi = nowTamagochi
            self.data = NowTamagochi.tamagochi
        }
        print(#function, NowTamagochi.tamagochi)
    }
    
    func configBaseSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self,
                           forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
}


extension SettingViewController: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(tableView)
    }
    
    func configLayout() {
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        navigationItem.title = ViewUIValue.settingView.navigationTitle
        setDefaultUI()
        tableView.backgroundColor = UIValue.color.background
    }
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewUIValue.settingView.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowIndex = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
   
        
        if let user {
            cell.delegate = self
            cell.configCell(rowIndex)
        }
    
        return cell
    }
}

extension SettingViewController: CellTransitionDelegate {
    func turnBackRootView() {
        print(#function)
        navigationPresentAfterView(view: ViewController(), style: .fullScreen, animated: false)
    }
    
    func pushAfterViewType<T: UIViewController>(type: T.Type, animated: Bool) {
        switch type {
        case is ChangeNameViewController.Type: 
            pushAfterView(view: ChangeNameViewController(), animated: animated)
        default: return
        }
        print(#function, type)
    }
    
    func pushChangeSelectView() {
        let vc = SelectViewController()
        vc.isChangeView = true
        pushAfterView(view: vc, animated: true)
    }
    
    func presentAlert(_ alert: UIAlertController, animated: Bool) {
        present(alert, animated: animated)
    }
    
    func popToRootViewFromCell(animated: Bool) {
        popToRootView(animated: animated)
    }
}


