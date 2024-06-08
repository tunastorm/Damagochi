//
//  SettingViewController.swift
//  Damagochi
//
//  Created by 유철원 on 6/8/24.
//

import UIKit

class SettingViewController: UIViewController {

    var user: User?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserData()
        configBaseSetting()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    func updateUserData() {
        if let nowUser = UserDefaultsManager.nowUser {
            NowUser.user = nowUser
            self.user = NowUser.user
        }
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
            cell.configCell(rowIndex)
        }
    
        return cell
    }
}
