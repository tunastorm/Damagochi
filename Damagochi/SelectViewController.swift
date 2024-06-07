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
        layout.minimumLineSpacing = UIViewResource.selectView.layoutMinLineSpacing
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let sectionInsets = UIViewResource.selectView.sectionInsets
    
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
        navigationItem.title = UIViewResource.selectView.navigationTitle
        setNavigationTitleColor(.white)
    }
}

extension SelectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemSize = UIViewResource.selectView.defaultItemSize
        let listSize = list.count
        
        if  listSize > itemSize {
            itemSize = listSize
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemIndex = indexPath.row
        print("itemIndex: \(itemIndex)")
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as? SelectCollectionViewCell else {
                    return UICollectionViewCell()
                }
    
        cell.backgroundColor = .clear
        
        if itemIndex < list.count {
            let data = list[itemIndex]
            cell.img.image = UIImage(named: data.image)
            cell.coverView.backgroundColor = .clear
            cell.label.text = "\(data.name) " + UIResource.damagochi
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height
            
            let itemsPerRow: CGFloat = UIViewResource.selectView.itemsPerRow // 최초 화면에 보여져야하는 row rottn
            let widthPadding = UIViewResource.selectView.widthPadding
            var itemsPerColumn: CGFloat = UIViewResource.selectView.itemsPerColumn // 최초 화면에 보여져야하는 columns 갯수
            print(itemsPerColumn)
            let heightPadding = UIViewResource.selectView.heightPadding
            
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
