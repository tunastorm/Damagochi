//
//  SelectedItemViewController.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import UIKit

class SelectedItemViewController: UIViewController {
    
    var data: Damagochi?
    
    let backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        return view
    }()
    
    let modalView: UIView = {
        var view = UIView()
        view.backgroundColor = UIValue.color.background
        view.layer.cornerRadius = ViewUIValue.selectedItemView.modalViewCornerRadious
        view.layer.masksToBounds = true

        return view
    }()
    
    let damagochiArea = UIView()
    let descriptionArea = UIView()
    let buttonArea = UIView()
    
    var img = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "1-1")
        $0.contentMode = .scaleToFill
    }
    
    var coverView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.layer.opacity = ViewUIValue.selectViewCell.coverViewOpactity
        $0.layer.cornerRadius = ViewUIValue.selectedItemView.coverViewCornerRadious
        $0.layer.masksToBounds = true
    }
    
    var labelView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIValue.color.background
        $0.layer.borderWidth = ViewUIValue.selectViewCell.labelViewBorderWidth
        $0.layer.borderColor = UIValue.color.border.cgColor
        $0.layer.cornerRadius = ViewUIValue.selectViewCell.labelViewCornerRadius
        $0.layer.masksToBounds = true
    }
    
    var nameLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        let fontSize = CGFloat(UIValue.fontSize.thin)
        $0.font = .boldSystemFont(ofSize: fontSize)
        $0.textColor = UIValue.color.font
        $0.text = ViewUIValue.selectViewCell.labelDefaultText
    }
    
    let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIValue.color.border
        return view
    }()
    
    let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIValue.color.border
        return view
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIValue.color.border
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIValue.fontSize.thin)
        label.numberOfLines = 0
        label.text = "준비중입니다"
        return label
    }()
    
    let cancleButton = {
        var button = UIButton()
        let title = ViewUIValue.selectedItemView.cancleButtonTitle
        let titleColor = UIValue.color.border
        button.setTitle(title, for:.normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: UIValue.fontSize.thin)
        button.addTarget(self, action: #selector(turnBack), for: .touchUpInside)
        return button
    }()
    
    let startButton = {
        var button = UIButton()
        let title = ViewUIValue.selectedItemView.startButtonTitle
        let titleColor = UIValue.color.border
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
        configHierarchy()
        configLayout()
        configUI()
        configCell()
    }
    
    func configCell() {
        guard let data else {return}
        img.image = UIImage(named: data.image)
        coverView.layer.opacity = 0
        let name = data.name + " \(UIValue.damagochi)"
        nameLabel.text = name
        let desc = "저는 \(name)입니당\n"
                 + "키는 \(data.height)Km, 몸무게는 \(data.weight)톤이에용\n"
                 + "성격은 화끈하고 날라다닙니당~!\n"
                 + "열심히 잘 먹고 잘 클 자신이 있습니당\n"
                 + "\(data.name)!"
        descLabel.text = desc
    }
    
    @objc func turnBack() {
       dismiss(animated: false)
    }
    
    @objc func goMainView() {
        if 
        let vc = MainViewController()
        vc.data = data
        navigationPresentAfterView(view: vc, style: .fullScreen, animated: false)
    }
}

extension SelectedItemViewController: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(modalView)
        view.bringSubviewToFront(modalView)
        
        modalView.addSubview(damagochiArea)
        modalView.addSubview(descriptionArea)
        modalView.addSubview(buttonArea)
        
        damagochiArea.addSubview(img)
        damagochiArea.addSubview(coverView)
        damagochiArea.addSubview(labelView)
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
        
        damagochiArea.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.45)
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        descriptionArea.snp.makeConstraints{
            $0.height.equalToSuperview().multipliedBy(0.45)
            $0.top.equalTo(damagochiArea.snp.bottom)
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
        
        coverView.snp.makeConstraints{
            $0.size.equalTo(120)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
            $0.bottom.equalTo(img.snp.bottom)
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
