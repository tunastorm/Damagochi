//
//  SettingTableViewCell.swift
//  Damagochi
//
//  Created by 유철원 on 6/8/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    let settingImage = UIImageView().then{
        $0.tintColor = UIValue.color.font
        $0.contentMode = .scaleToFill
    }
    
    let settingLabel = UILabel().then{
        $0.font = .systemFont(ofSize: UIValue.fontSize.thin)
        $0.textColor = UIValue.color.font
        $0.textAlignment = .left
    }
    
    let goButton = UIButton().then {
        $0.titleLabel?.font = .boldSystemFont(ofSize: UIValue.fontSize.thin)
        $0.titleLabel?.textColor = UIValue.color.font
        $0.titleLabel?.textAlignment = .right
        $0.setTitle(">", for: .normal)
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // MarketTableViewCell의 contentView에 추가하는 코드
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Error.cellInitFailed)
    }
    
    func configCell(_ rowIndex: Int) {
        switch rowIndex {
        case 0: configChangeUserName()
        case 1: configChangeDamagochi()
        case 2: configResetData()
        default: return
        }
    }
    
    func configChangeUserName() {
        settingImage.image = UIValue.image.writeName
        settingLabel.text = ViewUIValue.settingViewCell.changeUserNameLabel
        goButton.addTarget(self, action: #selector(goChangeNameView), for: .touchUpInside)
    }
    
    func configChangeDamagochi() {
        settingImage.image = UIValue.image.changeDamagochi
        settingLabel.text = ViewUIValue.settingViewCell.changeDamagochiLabel
        goButton.addTarget(self, action: #selector(goChangeDamagochiView), for: .touchUpInside)
        
    }
    
    func configResetData() {
        settingImage.image = UIValue.image.resetData
        settingLabel.text = ViewUIValue.settingViewCell.resetDataLabel
        goButton.addTarget(self, action: #selector(resetData), for: .touchUpInside)
        
    }
    
    @objc func goChangeNameView() {
        
    }
    
    @objc func goChangeDamagochiView() {
        
    }
    
    @objc func resetData() {
        
    }
}

extension SettingTableViewCell: CodeBaseUI {
    func configHierarchy() {
        contentView.addSubview(settingImage)
        contentView.addSubview(settingLabel)
        contentView.addSubview(goButton)
    }
    
    func configLayout() {
        settingImage.snp.makeConstraints{
            $0.size.equalTo(20)
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        settingLabel.snp.makeConstraints{
            $0.height.equalTo(20)
            $0.width.equalTo(150)
            $0.leading.equalTo(settingImage.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        goButton.snp.makeConstraints{
            $0.height.equalTo(20)
            $0.width.equalTo(50)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configUI() {
        self.backgroundColor = .clear
    }
}
