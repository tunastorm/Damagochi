//
//  SelectViewController.swift
//  Tamagochi
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
    var tamagochiList = NowTamagochi.nameList
    var data: Tamagochi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData(forUser: true, forTamagochi: true)
//        tamagochiChecker()
        configBasicSetting()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    func updateData(forUser: Bool, forTamagochi: Bool) {
        if let nowUser = UserDefaultsManager.nowUser, forUser {
            NowUser.user = nowUser
            self.user = NowUser.user
        }
           
        if let nowTamagochi = UserDefaultsManager.nowTamagochi, let user, forTamagochi {
            NowTamagochi.tamagochi = nowTamagochi
            self.data = NowTamagochi.tamagochi
        }
        print(#function, "user: \(user)")
        print(#function, "data: \(data)")
    }
    
    func configBasicSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectCollectionViewCell.self,
                                forCellWithReuseIdentifier: SelectCollectionViewCell.identifier)
    }
    
    func tamagochiChecker() -> TamagochiState {
        var tamagochiState = TamagochiState.none
        if let id = user?.tamagochi, id > 0 {
            tamagochiState = TamagochiState.exist
        }
        print(#function, tamagochiState)
        return tamagochiState
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
        
        if  tamagochiList.count > itemSize {
            itemSize = tamagochiList.count
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

        if itemIndex < tamagochiList.count, let data {
            cell.img.image = UIImage(named: "\(itemIndex+1)-\(data.level)")
            cell.coverView.backgroundColor = .clear
            cell.label.text = "\(tamagochiList[itemIndex]) " + UIValue.Tamagochi
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
        
        if indexPath.row < tamagochiList.count {
            vc.nameIndex = indexPath.row
        }
        navigationPresentAfterView(view: vc, style: .overFullScreen, animated: true)
    }
}
