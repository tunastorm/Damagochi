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
        $0.text = "따끔따끔 다마고치"
    }
    
    var statusLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: UIValue.fontSize.middle)
        $0.textColor = UIValue.color.font
        $0.text = "LV1﹒밥알 0개﹒물방울 0개"
    }
    
    var riceTextField = UITextField().then {
        $0.backgroundColor = .clear
    }
    
    var waterTextField = UITextField().then {
        $0.backgroundColor = .clear
    }
    
    var riceLineView = UIView()
    var waterLineView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configUI()
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
            $0.width.equalTo(220)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func configUI() {
        if let userName = user?.name {
            navigationItem.title = userName + ViewUIValue.MainView.navigationTitle
        }
        setDefaultUI()
        inputArea.backgroundColor = .red
        changeView.backgroundColor = .blue
    }
}
