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
    
    let damagochiArea = UIView()
    let inputArea = UIView()
    var bubbleView = UIView()
    let changeView = UIView()

    var bubble = UIImageView().then {
        $0.image = UIValue.image.bubble
        $0.contentMode = .scaleToFill
    }
    
    var bubbleLabel = UILabel().then {
        $0.text = UIValue.defaultMessage
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: UIValue.fontSize.thin)
        $0.textColor = UIValue.color.font
        $0.numberOfLines = 0
    }
    
    var img = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIValue.image.defaultDamagochi
        $0.contentMode = .scaleToFill
    }
    
    var coverView = UIView().then {
        $0.backgroundColor = .black
        $0.layer.opacity = UIValue.opacity.half
        $0.layer.cornerRadius = ViewUIValue.MainView.coverViewCornerRadious
        $0.layer.masksToBounds = true
    }
    
    var labelView = UIView().then {
        $0.backgroundColor = UIValue.color.background
        $0.layer.borderWidth = ViewUIValue.selectViewCell.labelViewBorderWidth
        $0.layer.borderColor = UIValue.color.border
        $0.layer.cornerRadius = ViewUIValue.selectViewCell.labelViewCornerRadius
        $0.layer.masksToBounds = true
    }
    
    var nameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: UIValue.fontSize.thin)
        $0.textColor = UIValue.color.font
        $0.text = UIValue.defaultMessage
    }
    
    var statusLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: UIValue.fontSize.middle)
        $0.textColor = UIValue.color.font
        $0.text = UIValue.defaultMessage
    }
    
    var riceTextField = UITextField().then {
        $0.backgroundColor = .clear
        $0.placeholder = ViewUIValue.MainView.eatRicePlaceholder
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: UIValue.fontSize.thin)
    }
    
    var waterTextField = UITextField().then {
        $0.backgroundColor = .clear
        $0.placeholder = ViewUIValue.MainView.eatWaterPlaceholder
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: UIValue.fontSize.thin)
    }
    
    var riceLineView = UIView().then {
        $0.backgroundColor = UIValue.color.font
    }
    var waterLineView = UIView().then{
        $0.backgroundColor = UIValue.color.font
    }
    
    var riceEatButton = UIButton().then{
        $0.setEatButtonUI()
        $0.setTitle(ViewUIValue.MainView.eatRiceButtonTitle, for: .normal)
        $0.setImage(UIValue.image.eatRice, for: .normal)
        $0.addTarget(self, action: #selector(eatRice), for: .touchUpInside)
    }
    
    var waterEatButton = UIButton().then{
        $0.setEatButtonUI()
        $0.setTitle(ViewUIValue.MainView.eatWaterButtonTitle, for: .normal)
        $0.setImage(UIValue.image.eatWater, for: .normal)
        $0.addTarget(self, action: #selector(eatWater), for: .touchUpInside)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData(forUser: true, forDamagochi: true)
        configHierarchy()
        configLayout()
        configUI()
        configData()
    }

    func updateData(forUser: Bool, forDamagochi: Bool) {
        if let nowUser = UserDefaultsManager.nowUser, forUser {
            NowUser.user = nowUser
            self.user = NowUser.user
        }
           
        if let damagochiList = UserDefaultsManager.damagochiList, let user, forDamagochi {
            DamagochiList.list = damagochiList
            self.data = DamagochiList.list[user.damagochi-1]
        }
    }
    
    func configData() {
        if let user, let data {
            bubbleLabel.text = damagochiMessage.list.randomElement()?.replacingOccurrences(of: "userName", with: user.name)
            img.image = UIImage(named: data.image)
            coverView.backgroundColor = .clear
            nameLabel.text = data.name + " \(UIValue.damagochi)"
            statusLabel.text = "LV\(data.level)﹒밥알 \(data.rice)개﹒물방울 \(data.water)개"
        }
    }
    
    @objc func eatRice(_ sender: UIButton) {
        guard let data else {return}
        var number = 1
        if let input = Int(riceTextField.text ?? "1"), input <= 99 {
            number = input
        }
        print(#function, "DamagochiList.list: \(DamagochiList.list)")
        let newRice = DamagochiList.list[data.id-1].rice + number
        print(#function, "newRice: \(newRice)")
        DamagochiList.list[data.id-1].rice = newRice
        UserDefaultsManager.damagochiList = DamagochiList.list

        updateData(forUser: false, forDamagochi: true)
        configData()
    }
    
    @objc func eatWater(_ sender: UIButton) {
        guard let data else {return}
        var number = 1
        if let input = Int(waterTextField.text ?? "1"), input <= 49 {
            number = input
        }
        print(#function, "DamagochiList.list: \(DamagochiList.list)")
        let newWater = DamagochiList.list[data.id-1].water + number
        print(#function, "newWater: \(newWater)")
        DamagochiList.list[data.id-1].water = newWater
        UserDefaultsManager.damagochiList = DamagochiList.list
        
        updateData(forUser: false, forDamagochi: true)
        configData()
    }
}

extension MainViewController: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(damagochiArea)
        view.addSubview(inputArea)
        damagochiArea.addSubview(bubbleView)
        bubbleView.addSubview(bubble)
        bubbleView.addSubview(bubbleLabel)
        damagochiArea.addSubview(img)
        damagochiArea.addSubview(coverView)
        damagochiArea.addSubview(labelView)
        labelView.addSubview(nameLabel)
        damagochiArea.addSubview(statusLabel)
        
        inputArea.addSubview(changeView)
        changeView.addSubview(riceTextField)
        changeView.addSubview(riceLineView)
        changeView.addSubview(riceEatButton)
        changeView.addSubview(waterTextField)
        changeView.addSubview(waterLineView)
        changeView.addSubview(waterEatButton)
    }
    
    func configLayout() {
        damagochiArea.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        inputArea.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.top.equalTo(damagochiArea.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        bubbleView.snp.makeConstraints{
            $0.width.equalTo(200)
            $0.height.equalTo(120)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        bubble.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bubbleLabel.snp.makeConstraints{
            $0.top.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        img.snp.makeConstraints {
            $0.size.equalTo(220)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bubbleView.snp.bottom).offset(4)
        }
        
        coverView.snp.makeConstraints{
            $0.size.equalTo(220)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bubbleView.snp.bottom).offset(4)
            $0.bottom.equalTo(img.snp.bottom)
        }
        
        labelView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(img.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(5)
        }
        
        statusLabel.snp.makeConstraints{
            $0.height.equalTo(20)
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        changeView.snp.makeConstraints{
            $0.height.equalTo(140)
            $0.width.equalTo(240)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        riceTextField.snp.makeConstraints{
            $0.height.equalTo(30)
            $0.width.equalTo(150)
            $0.top.leading.equalToSuperview()
        }
        
        riceLineView.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.width.equalTo(riceTextField)
            $0.top.equalTo(riceTextField.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        riceEatButton.snp.makeConstraints{
            $0.height.equalTo(riceTextField)
            $0.width.equalTo(80)
            $0.leading.equalTo(riceTextField.snp.trailing).offset(10)
            $0.top.trailing.equalToSuperview()
        }
        
        waterTextField.snp.makeConstraints{
            $0.height.equalTo(riceTextField)
            $0.width.equalTo(riceTextField)
            $0.top.equalTo(riceLineView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
        }
        
        waterLineView.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.width.equalTo(waterTextField)
            $0.top.equalTo(waterTextField.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        waterEatButton.snp.makeConstraints{
            $0.height.equalTo(waterTextField)
            $0.width.equalTo(riceEatButton)
            $0.top.equalTo(riceEatButton.snp.bottom).offset(21)
            $0.leading.equalTo(riceTextField.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            
        }
    }
    
    func configUI() {
        if let userName = user?.name {
            navigationItem.title = userName + ViewUIValue.MainView.navigationTitle
        }
        setDefaultUI()
    }
}
