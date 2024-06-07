//
//  SelectViewController.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit
import SnapKit

class SelectViewTable: UIViewController {
    
    let tableView = UITableView()

    let list: [Damagochi] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseConfig()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    func setBaseConfig() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectTableViewCell.self,
                           forCellReuseIdentifier: SelectTableViewCell.identifier)
    }
}

extension SelectViewTable: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(tableView)
    }
    
    func configLayout() {
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        view.backgroundColor = UIValue.color.background
        tableView.rowHeight = 150
    }

}

extension SelectViewTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.identifier, for: indexPath)
        
        return cell
    }
}
