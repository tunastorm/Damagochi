//
//  MainViewController.swift
//  Tamagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit

class MainViewController: UIViewController {
    
    var user: User?
    var data: Tamagochi?
    
    let TamagochiArea = UIView()
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
        $0.numberOfLines = UIValue.numberOflineZero
    }
    
    var img = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIValue.image.defaultTamagochi
        $0.contentMode = .scaleToFill
    }
    
    var coverView = UIView().then {
        $0.backgroundColor = .black
        $0.layer.opacity = UIValue.opacity.half
        $0.layer.cornerRadius = ViewUIValue.mainView.coverViewCornerRadious
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
        $0.placeholder = ViewUIValue.mainView.eatRicePlaceholder
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: UIValue.fontSize.thin)
    }
    
    var waterTextField = UITextField().then {
        $0.backgroundColor = .clear
        $0.placeholder = ViewUIValue.mainView.eatWaterPlaceholder
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
        $0.setTitle(ViewUIValue.mainView.eatRiceButtonTitle, for: .normal)
        $0.setImage(UIValue.image.eatRice, for: .normal)
        $0.addTarget(self, action: #selector(eatRice), for: .touchUpInside)
    }
    
    var waterEatButton = UIButton().then{
        $0.setEatButtonUI()
        $0.setTitle(ViewUIValue.mainView.eatWaterButtonTitle, for: .normal)
        $0.setImage(UIValue.image.eatWater, for: .normal)
        $0.addTarget(self, action: #selector(eatWater), for: .touchUpInside)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData(forUser: true, forTamagochi: true)
        configNavigationBar()
        configHierarchy()
        configLayout()
        configUI()
        configData()
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
    
    func configData() {
        if let user, let data {
            bubbleLabel.text = TamagochiMessage.list.randomElement()?.replacingOccurrences(of: "userName", with: user.name)
            img.image = UIImage(named: data.image)
            coverView.backgroundColor = .clear
            nameLabel.text = data.name + " \(UIValue.Tamagochi)"
            statusLabel.text = "LV\(data.level)﹒밥알 \(data.rice)개﹒물방울 \(data.water)개"
        }
    }
    
    func configNavigationBar() {
        let barButton = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: #selector(goSettingView)
        )
        barButton.tintColor = UIValue.color.font
        barButton.image = UIValue.image.personCircle
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func eatRice(_ sender: UIButton) {
        var number = ViewUIValue.mainView.eatMinValue
        
        guard let input = riceTextField.text else {return}
        
        if input.isEmpty { // 빈 값 입력시 최소값(1) 유지
            
        } else if input.allSatisfy({ $0.isNumber }) { // riceMax 이하의 정수 N 입력 시 N증가
            guard let inputNum = Int(input),
                      inputNum <= ViewUIValue.mainView.riceMax else {return}
            number = inputNum
        } else { // 그 외 예외처리
            return
        }
        
        print(#function, "NowTamagochi.tamagochi: \(NowTamagochi.tamagochi)")
        let newRice = NowTamagochi.tamagochi.rice + number
        print(#function, "newRice: \(newRice)")
        NowTamagochi.tamagochi.rice = newRice
        UserDefaultsManager.nowTamagochi = NowTamagochi.tamagochi
        
        saveData(forUser: false, forTamagochi: true)
        updateData(forUser: false, forTamagochi: true)
        configData()
    }
    
    @objc func eatWater(_ sender: UIButton) {
        var number = ViewUIValue.mainView.eatMinValue
        
        guard let input = waterTextField.text else {return}
        
        if input.isEmpty { // 빈 값 입력시 최소값(1) 유지
            
        } else if input.allSatisfy({ $0.isNumber }) { // waterMax 이하의 정수 N 입력 시 N증가
            guard let inputNum = Int(input),
                      inputNum <= ViewUIValue.mainView.warterMax else {return}
            number = inputNum
        } else { // 그 외 예외처리
            return
        }
        
        print(#function, "NowTamagochi.tamagochi: \(NowTamagochi.tamagochi)")
        let newWater = NowTamagochi.tamagochi.water + number
        print(#function, "newWater: \(newWater)")
        NowTamagochi.tamagochi.water = newWater
        UserDefaultsManager.nowTamagochi = NowTamagochi.tamagochi
        
        saveData(forUser: false, forTamagochi: true)
        updateData(forUser: false, forTamagochi: true)
        configData()
    }
    
    @objc func goSettingView() {
        pushAfterView(view: SettingViewController(), animated: true)
    }
    
}


extension MainViewController: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(TamagochiArea)
        view.addSubview(inputArea)
        TamagochiArea.addSubview(bubbleView)
        bubbleView.addSubview(bubble)
        bubbleView.addSubview(bubbleLabel)
        TamagochiArea.addSubview(img)
        TamagochiArea.addSubview(coverView)
        TamagochiArea.addSubview(labelView)
        labelView.addSubview(nameLabel)
        TamagochiArea.addSubview(statusLabel)
        
        inputArea.addSubview(changeView)
        changeView.addSubview(riceTextField)
        changeView.addSubview(riceLineView)
        changeView.addSubview(riceEatButton)
        changeView.addSubview(waterTextField)
        changeView.addSubview(waterLineView)
        changeView.addSubview(waterEatButton)
    }
    
    func configLayout() {
        TamagochiArea.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        inputArea.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.top.equalTo(TamagochiArea.snp.bottom)
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
            navigationItem.title = userName + ViewUIValue.mainView.navigationTitle
        }
        navigationItem.backButtonTitle = ""
        setDefaultUI()
    }
}
