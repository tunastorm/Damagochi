//
//  SelectTableViewCell.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit
import SnapKit
import Kingfisher

class SelectTableViewCell: UITableViewCell {
    
    let stackView = UIStackView()
    let leftView = UIView()
    let centerView = UIView()
    let rightView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // MarketTableViewCell의 contentView에 추가하는 코드
        configHierarchy()
        configLayout()
        configUI()
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Error.collectionViewCellInitFailed)
    }
    
    func configCell() {
        
    }
}

extension SelectTableViewCell: CodeBaseUI{
    func configHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(centerView)
        stackView.addArrangedSubview(rightView)
    }
    
    func configLayout() {
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func configUI() {
        self.backgroundColor = UIValue.color.background
        leftView.backgroundColor = .blue
        centerView.backgroundColor = .green
        rightView.backgroundColor = .brown
    }
    
    func setItmes() {
        for view in [leftView, centerView, rightView] {
            let imageView = UIImageView()
            let labelView = UIView()
            let label = UILabel()
            
            view.addSubview(imageView)
            labelView.addSubview(label)
            view.addSubview(labelView)
            
            let width = self.frame.width * 0.41

            view.snp.makeConstraints{
                $0.width.equalTo(width)
            }
    
            imageView.snp.makeConstraints{
                $0.size.equalTo(100)
                $0.top.horizontalEdges.equalToSuperview().inset(10)
            }
            
            labelView.snp.makeConstraints{
                $0.top.equalTo(imageView.snp.bottom)
                $0.horizontalEdges.bottom.equalToSuperview().inset(10)
            }
            
            label.snp.makeConstraints{
                $0.verticalEdges.equalToSuperview().inset(5)
                $0.horizontalEdges.equalToSuperview().inset(5)
            }
        }
    }
}
