//
//  SelectedItemViewController.swift
//  Tamagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit

class SelectedItemViewController: UIViewController {
    
    var user: User?
    var data: Tamagochi = NowTamagochi.tamagochi
    var nameIndex: Int?
    var id: Int?
    var name: String?
    var isChangeView = false
    
    let backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = UIValue.opacity.half
        return view
    }()
    
    let modalView: UIView = {
        var view = UIView()
        view.backgroundColor = UIValue.color.background
        view.layer.cornerRadius = ViewUIValue.selectedItemView.modalViewCornerRadious
        view.layer.masksToBounds = true

        return view
    }()
    
    let TamagochiArea = UIView()
    let descriptionArea = UIView()
    let buttonArea = UIView()
    
    var img = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIValue.image.defaultTamagochi
        $0.contentMode = .scaleToFill
    }
    
    var labelView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIValue.color.background
        $0.layer.borderWidth = ViewUIValue.selectViewCell.labelViewBorderWidth
        $0.layer.borderColor = UIValue.color.border
        $0.layer.cornerRadius = ViewUIValue.selectViewCell.labelViewCornerRadius
        $0.layer.masksToBounds = true
    }
    
    var nameLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        let fontSize = CGFloat(UIValue.fontSize.thin)
        $0.font = .boldSystemFont(ofSize: fontSize)
        $0.textColor = UIValue.color.font
        $0.text = UIValue.defaultMessage
    }
    
    let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIValue.color.font
        return view
    }()
    
    let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIValue.color.font
        return view
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIValue.color.font
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIValue.fontSize.thin)
        label.numberOfLines = UIValue.numberOflineZero
        label.text = UIValue.defaultMessage
        return label
    }()
    
    let cancleButton = {
        var button = UIButton()
        let title = ViewUIValue.selectedItemView.cancleButtonTitle
        let titleColor = UIValue.color.font
        button.setTitle(title, for:.normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: UIValue.fontSize.thin)
        button.addTarget(self, action: #selector(turnBack), for: .touchUpInside)
        return button
    }()
    
    let startButton = {
        var button = UIButton()
        var title = ViewUIValue.selectedItemView.startButtonTitle
        let titleColor = UIValue.color.font
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = UIValue.color.background
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: UIValue.fontSize.thin)
        button.addTarget(self, action: #selector(goMainView), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData(forUser: true, forTamagochi: false)
        configHierarchy()
        configLayout()
        configUI()
        configCell()
    }
    
    func updateData(forUser: Bool, forTamagochi: Bool) {
        if let nowUser = UserDefaultsManager.nowUser, forUser {
            NowUser.user = nowUser
            self.user = NowUser.user
        }
           
        if let nowTamagochi = UserDefaultsManager.nowTamagochi , let user, forTamagochi {
            NowTamagochi.tamagochi = nowTamagochi
            self.data = NowTamagochi.tamagochi
        }
    }
    
    func configCell() {
        guard let nameIndex else {return}
        id = nameIndex + 1
        guard let id else {return}
        print(#function,"| id: \(id) | ", "data.level: \(data.level)")
        
        var imgLevel = data.level
        if imgLevel >= 10 {
            imgLevel = 9
        }
        img.image = UIImage(named: "\(id)-\(imgLevel)")
       
        name = NowTamagochi.nameList[nameIndex]
        guard let name else {return}
        let fullName = name + " \(UIValue.Tamagochi)"
        nameLabel.text = fullName
        var desc = ""
        let descList = ViewUIValue.selectedItemView.descriptionBase
        let descValues = [fullName, String(data.height), String(data.weight), name]
        for (idx, regx) in ViewUIValue.selectedItemView.descriptionRegx.enumerated() {
            let line = descList[idx].replacingOccurrences(of:regx, with:descValues[idx])
            desc = desc + line
        }
        descLabel.text = desc
        
        if isChangeView {
            startButton.setTitle(ViewUIValue.selectedItemView.changeButtonTitle,
                                 for: .normal)
        }
    }
    
    @objc func turnBack() {
       dismiss(animated: false)
    }
    
    @objc func goMainView() {
        if let id, let name, user?.tamagochi != id { // id = nameIndex + 1
            NowUser.user.tamagochi = id
            NowTamagochi.tamagochi.setId(id)
            NowTamagochi.tamagochi.setName(name)
            NowTamagochi.tamagochi.setImage(self.isChangeView)
            print(#function, NowUser.user)
            print(#function, NowTamagochi.tamagochi)
        }
        saveData(forUser: true, forTamagochi: true)
        navigationPresentAfterView(view: MainViewController(), style: .fullScreen, animated: false)
    }
}

extension SelectedItemViewController: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(modalView)
        view.bringSubviewToFront(modalView)
        
        modalView.addSubview(TamagochiArea)
        modalView.addSubview(descriptionArea)
        modalView.addSubview(buttonArea)
        
        TamagochiArea.addSubview(img)
        TamagochiArea.addSubview(labelView)
        labelView.addSubview(nameLabel)
        
        descriptionArea.addSubview(lineView1)
        descriptionArea.addSubview(descLabel)
        
        buttonArea.addSubview(lineView2)
        buttonArea.addSubview(cancleButton)
        buttonArea.addSubview(startButton)
    }
    
    func configLayout() {
        backgroundView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        modalView.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
        }
        
        TamagochiArea.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.45)
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        descriptionArea.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.45)
            $0.top.equalTo(TamagochiArea.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        
        buttonArea.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.top.equalTo(descriptionArea.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        
        img.snp.makeConstraints {
            $0.size.equalTo(120)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
        }
        
        labelView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(img.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(5)
        }
        
        lineView1.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        descLabel.snp.makeConstraints{
            $0.top.equalTo(lineView1.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        lineView2.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        cancleButton.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.top.equalTo(lineView2.snp.bottom)
            $0.leading.bottom.equalToSuperview()
        }
        startButton.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.top.equalTo(lineView2.snp.bottom)
            $0.leading.equalTo(cancleButton.snp.trailing)
            $0.trailing.bottom.equalToSuperview()
        }
    }
    
    func configUI() {
        
    }
    
}
