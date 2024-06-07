//
//  SelectCollectionViewCell.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit
import SnapKit
import Then


class SelectCollectionViewCell: UICollectionViewCell {
    
    // 뷰 객체 생성 및 초기화
    var img = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "1-1")
    }
    
    var coverView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.layer.opacity = 0.5
        $0.layer.cornerRadius = 50
        $0.layer.masksToBounds = true
    }
    
    var labelView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIResource.color.background
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIResource.color.border.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    var label = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        let fontSize = CGFloat(UIResource.fontSize.thin)
        $0.font = .boldSystemFont(ofSize: fontSize)
        $0.textColor = UIResource.color.font
        $0.text = "준비중이에요"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetting() {
        self.backgroundColor = .gray
        self.addSubview(img)
        self.addSubview(coverView)
        self.addSubview(labelView)
        labelView.addSubview(label)
        
        
        img.contentMode = .scaleToFill
        img.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(0)
            $0.bottom.equalTo(-30)
        }
        
        coverView.snp.makeConstraints{
            $0.leading.top.trailing.equalTo(0)
            $0.bottom.equalTo(-30)
        }
        
        labelView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(0)
            $0.top.equalTo(img.snp.bottom).offset(5)
        }
        label.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(5)
        }
    }
}
