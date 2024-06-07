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
        layout.minimumLineSpacing = ViewUIValue.selectView.layoutMinLineSpacing
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let sectionInsets = ViewUIValue.selectView.sectionInsets
    
    var user: User?
    var damagochiList: [Damagochi]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        damagochiListChecker()
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
    
    func damagochiListChecker() -> DamagochiState {
        var damagochiState = DamagochiState.noList
        if let list = UserDefaultsManager.damagochiList {
            damagochiState = DamagochiState.existList
            DamagochiList.list = list
            damagochiList = DamagochiList.list
        } else {
            UserDefaultsManager.damagochiList = DamagochiList.list
            damagochiList =  UserDefaultsManager.damagochiList
            damagochiState = DamagochiState.existList
        }
        return damagochiState
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
        setDefaultUI()
        navigationItem.title = ViewUIValue.selectView.navigationTitle
    }
}

extension SelectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemSize = ViewUIValue.selectView.defaultItemSize
        
        if let listSize = damagochiList?.count, listSize > itemSize {
            itemSize = listSize
        }

        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemIndex = indexPath.row
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath)
        as? SelectCollectionViewCell else {
             return UICollectionViewCell()
        }
    
        cell.backgroundColor = .clear

        if let list = damagochiList, itemIndex < list.count {
            let data = list[itemIndex]
            cell.img.image = UIImage(named: data.image)
            cell.coverView.backgroundColor = .clear
            cell.label.text = "\(data.name) " + UIValue.damagochi
        }
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height
            
            let itemsPerRow: CGFloat = ViewUIValue.selectView.itemsPerRow // 최초 화면에 보여져야하는 row rottn
            let widthPadding = ViewUIValue.selectView.widthPadding
            var itemsPerColumn: CGFloat = ViewUIValue.selectView.itemsPerColumn // 최초 화면에 보여져야하는 columns 갯수
            let heightPadding = ViewUIValue.selectView.heightPadding
            
            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = (height - heightPadding) / itemsPerColumn
        
            print("cellWidth: \(cellWidth)")
            print("cellHeight: \(cellHeight)")
            
            return CGSize(width: cellWidth, height: cellHeight)
    }
        
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SelectedItemViewController()
        
        if let list = damagochiList, indexPath.row < list.count {
            vc.user = user
            vc.data = list[indexPath.row]
        }
        navigationPresentAfterView(view: vc, style: .overFullScreen, animated: true)
    }
}
