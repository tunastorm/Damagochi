//
//  SelectViewController.swift
//  Damagochi
//
//  Created by 유철원 on 6/6/24.
//

import UIKit

class SelectViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .green
        return cv
    }()
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    
    let list = Dummy.dummyList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBasicSetting()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    func configBasicSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectCollectionViewCell.self,
                                forCellWithReuseIdentifier: SelectCollectionViewCell.identifier)
    }

}

extension SelectViewController: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configLayout() {
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        view.backgroundColor = UIResource.color.background
    }
}

extension SelectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemSize = 0
        let listSize = list.count
        
        if  listSize < 20 {
            itemSize = 20
        } else {
            itemSize = listSize
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as? SelectCollectionViewCell else {
                    return UICollectionViewCell()
                }
        cell.backgroundColor = .none
        
        // 해당 Item의 내용에 맞게 변경 
//        cell.img.image = UIImage(named: "1-9")
//        cell.label.text = "고래고래"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height
            
            let itemsPerRow: CGFloat = 3 // 최초 화면에 보여져야하는 row rottn
            let widthPadding = sectionInsets.left * (itemsPerRow + 1)
            var itemsPerColumn: CGFloat = 4 // 최초 화면에 보여져야하는 columns 갯수
            itemsPerColumn = ceil(itemsPerColumn)
            print(itemsPerColumn)
            let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
            
            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = (height - heightPadding) / itemsPerColumn
            
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        // case A
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }
        
        // case B
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
        }
}
