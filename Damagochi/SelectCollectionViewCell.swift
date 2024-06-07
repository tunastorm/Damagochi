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
        $0.layer.cornerRadius = 70
        $0.layer.masksToBounds = true
    }
    
    var label = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
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
        self.addSubview(label)
        
        img.contentMode = .scaleToFill
        img.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(0)
            $0.bottom.equalTo(-20)
        }
        
        coverView.snp.makeConstraints{
            $0.leading.top.trailing.equalTo(0)
            $0.bottom.equalTo(-20)
        }
        
        label.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(0)
            $0.top.equalTo(img.snp.bottom)
        }
    }
}
