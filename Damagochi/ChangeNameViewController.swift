//
//  ChangeNameViewController.swift
//  Damagochi
//
//  Created by 유철원 on 6/9/24.
//

import UIKit
import SnapKit
import Then

class ChangeNameViewController: UIViewController {
//    
//    var delegate: ViewTransition?
    
    let newNameTextField = UITextField().then{
        $0.textColor = UIValue.color.font
        $0.font = .boldSystemFont(ofSize: UIValue.fontSize.thin)
        $0.textAlignment = .natural
    }
    
    let lineView = UIView().then{
        $0.backgroundColor = UIValue.color.font
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBaseSetting()
        configNavigationBar()
        configHierarchy()
        configLayout()
        configUI()
        
    }
    
    func configBaseSetting() {
        newNameTextField.delegate = self
    }
    
    func configNavigationBar() {
        let barButton = UIBarButtonItem(
            title: ViewUIValue.changeNameView.saveButtonTitle,
            style: .plain,
            target: self,
            action: #selector(saveNewName)
        )
        barButton.tintColor = UIValue.color.font
        navigationItem.rightBarButtonItem = barButton
    }
    
    
    @objc func saveNewName() {
        guard let newName = newNameTextField.text else {return}
        let namelength = newName.count
        let minLength = ViewUIValue.changeNameView.newNameMinLength
        let maxLength = ViewUIValue.changeNameView.newNameMaxLength
        
        if namelength < minLength || namelength > maxLength {
            return
        }
        NowUser.name = newName
        UserDefaultsManager.nowUser = NowUser.user
        
        guard let viewStacks = self.navigationController?.viewControllers else {return}
        for view in viewStacks {
            if let mainView = view as? MainViewController {
//                delegate = MainView
                popToBeforeView(mainView, animated: true)
//                dismiss(animated: false, completion: )
//                navigationPresentAfterView(view: mainView, style: .fullScreen, animated: false)
            }
        }
    }
}

extension ChangeNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newNameTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension ChangeNameViewController: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(newNameTextField)
        view.addSubview(lineView)
    }
    
    func configLayout() {
        newNameTextField.snp.makeConstraints{
            $0.height.equalTo(30)
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        lineView.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.top.equalTo(newNameTextField.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configUI() {
        setDefaultUI()
        navigationItem.title = NowUser.user.name + ViewUIValue.changeNameView.navigtaionTitle
    }
}
