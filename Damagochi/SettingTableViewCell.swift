//
//  SettingTableViewCell.swift
//  Tamagochi
//
//  Created by 유철원 on 6/8/24.
//

import UIKit
import SnapKit
import Then

class SettingTableViewCell: UITableViewCell {
    
    var delegate: CellTransitionDelegate?
    
    let settingImage = UIImageView().then{
        $0.tintColor = UIValue.color.font
        $0.contentMode = .scaleToFill
    }
    
    let settingLabel = UILabel().then {
        $0.font = .systemFont(ofSize: UIValue.fontSize.thin)
        $0.textColor = UIValue.color.font
        $0.textAlignment = .left
    }
   
    let goButton = UIButton().then {
//        $0.configuration = .plain()
//        $0.configuration?.imagePlacement = .trailing
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleLabel?.font = .boldSystemFont(ofSize: UIValue.fontSize.thin)
//        $0.titleLabel?.textAlignment
        $0.tintColor = .systemGray3
        $0.setTitleColor(UIValue.color.font, for: .normal)
        $0.setImage(UIValue.image.chevronRight, for: .normal)
        $0.contentMode = .scaleToFill
        
        $0.contentHorizontalAlignment = .leading
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
//        $0.backgroundColor = .blue
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
        
        goButton.setAttributedTitle(NSAttributedString(string: NowUser.name), for: .normal)
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
        goButton.addTarget(self, action: #selector(resetDataAlert), for: .touchUpInside)
        
    }
    
    @objc func goChangeNameView() {
        delegate?.pushAfterViewType(type: ChangeNameViewController.self, animated: true)
    }
    
    @objc func goChangeTamagochiView() {
        delegate?.pushChangeSelectView()
    }
    
    @objc func resetDataAlert() {
        let alert = UIAlertController(title: ViewUIValue.settingViewCell.resetDataLabel,
                                      message: ViewUIValue.settingViewCell.resetDataMessage,
                                      preferredStyle: .alert)
        // 2.
        let delete = UIAlertAction(title: ViewUIValue.settingViewCell.resetAlertDelete,
                                   style: .destructive,
                                   handler: {_  in self.resetData()})
        
        let cancle = UIAlertAction(title: ViewUIValue.settingViewCell.resetAlertCancle,
                                   style: .cancel)
        
        // 3. addAction 순서대로 좌->우, 상->하로 정렬
        // 하지만 UIAlertAction의 style 파라미터에 정의된 스타일에 지정된 위치가 우선한다.
        alert.addAction(cancle)
        alert.addAction(delete)
        
        delegate?.presentAlert(alert, animated: false)
    }
    
    func resetData() {
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
            $0.height.equalTo(40)
            $0.width.equalTo(100)
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
