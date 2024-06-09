//
//  SelectCollectionViewCell.swift
//  Tamagochi
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
    
    var label = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        let fontSize = CGFloat(UIValue.fontSize.thin)
        $0.font = .boldSystemFont(ofSize: fontSize)
        $0.textColor = UIValue.color.font
        $0.text = UIValue.defaultMessage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Error.cellInitFailed)
    }
}


extension SelectCollectionViewCell: CodeBaseUI {
    func configHierarchy() {
        self.addSubview(img)
        self.addSubview(labelView)
        labelView.addSubview(label)
    }
    
    func configLayout() {
        img.snp.makeConstraints {
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
    
    func configUI() {
        self.backgroundColor = .gray
    }
}
