//
//  SettingTableViewCell.swift
//  Tamagochi
//
//  Created by 유철원 on 6/8/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    var delegate: CellTransitionDelegate?
    
    let settingImage = UIImageView().then{
        $0.tintColor = UIValue.color.font
        $0.contentMode = .scaleToFill
    }
    
    let settingLabel = UILabel().then{
        $0.font = .systemFont(ofSize: UIValue.fontSize.thin)
        $0.textColor = UIValue.color.font
        $0.textAlignment = .left
    }
    
    var configuration = UIButton.Configuration.plain()
   
    let goButton = UIButton(type:.system).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.configuration = .plain()
//        $0.configuration?.imagePlacement = .trailing
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleLabel?.font = .boldSystemFont(ofSize: UIValue.fontSize.thin)
        $0.titleLabel?.textAlignment = .right
        $0.tintColor = .systemGray3
        $0.setTitleColor(UIValue.color.font, for: .normal)
        $0.setImage(UIValue.image.chevronRight, for: .normal)
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .blue
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
        case 1: configChangeTamagochi()
        case 2: configResetData()
        default: return
        }
    }
    
    func configChangeUserName() {
        settingImage.image = UIValue.image.writeName
        settingLabel.text = ViewUIValue.settingViewCell.changeUserNameLabel
        goButton.setTitle(NowUser.user.name, for: .normal)
        goButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        goButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0,
                                                     bottom: 0, right: 10)
        goButton.addTarget(self, action: #selector(goChangeNameView), for: .touchUpInside)
    }
    
    func configChangeTamagochi() {
        settingImage.image = UIValue.image.changeTamagochi
        settingLabel.text = ViewUIValue.settingViewCell.changeTamagochiLabel
       
        goButton.addTarget(self, action: #selector(goChangeTamagochiView), for: .touchUpInside)
        
    }
    
    func configResetData() {
        settingImage.image = UIValue.image.resetData
        settingLabel.text = ViewUIValue.settingViewCell.resetDataLabel
        goButton.addTarget(self, action: #selector(resetData), for: .touchUpInside)
        
    }
    
    @objc func goChangeNameView() {
        
    }
    
    @objc func goChangeTamagochiView() {
        
    }
    
    @objc func resetData() {
        print("hihihihi")
        let userKey = UserDefaultsManager.userKey
        let dataKey = UserDefaultsManager.tamagochiKey
        NowUser.user = DefaultData.user
        NowTamagochi.tamagochi = DefaultData.tamagochi
        UserDefaultsManager.removeValue(userKey)
        UserDefaultsManager.removeValue(dataKey)
        
        if let user = UserDefaultsManager.nowUser,
           let tamagochi = UserDefaultsManager.nowTamagochi {
            print(#function, user)
            print(#function, tamagochi)
        }
        delegate?.turnBackRootView()
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
            $0.width.equalTo(100)
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configUI() {
        self.backgroundColor = .clear
    }
}
