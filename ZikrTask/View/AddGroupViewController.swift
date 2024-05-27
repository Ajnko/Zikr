//
//  AddGroupViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 22/05/24.
//

import UIKit
import SnapKit

class AddGroupViewController: UIViewController {
    
    let titleImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .lightMode
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.5
        image.layer.shadowOffset = CGSize(width: 0, height: 5)
        image.layer.shadowRadius = 4
        image.layer.cornerRadius = 50
        return image
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.tintColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.backgroundColor = .lightMode
        return view
    }()
    
    let plusImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        image.contentMode = .scaleAspectFit
        image.tintColor = .darkMode
        return image
    }()
    
    let groupName = CustomLabel(
        text: "Guruh Nomi",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let groupTextField = CustomTextField(
        placeholder: "Guruh nomi",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .lightMode,
        cornerRadius: 10
    )
    
    let zikrName = CustomLabel(
        text: "Zikr Nomi",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let zikrTextField = CustomTextField(
        placeholder: "Zikr nomi",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .lightMode,
        cornerRadius: 10
    )
    
    let zikrInfo = CustomLabel(
        text: "Zikr Info",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let zikrInfoTextField = CustomTextField(
        placeholder: "Zikr info",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .lightMode,
        cornerRadius: 10
    )
    
    let zikrCount = CustomLabel(
        text: "Zikr Count",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let zikrCountTextField = CustomTextField(
        placeholder: "Zikr count",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .lightMode,
        cornerRadius: 10
    )
    
    let saveButton: UIButton = {
       let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2107380927, green: 0.2562682629, blue: 0.3235290051, alpha: 1), for: .normal)
        button.backgroundColor = .lightMode
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightMode
        
        setupUI()
        paddingViewForTextField()
        shadowsForTextField()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        groupTextField.inputAccessoryView = toolbar
        zikrTextField.inputAccessoryView = toolbar
        zikrInfoTextField.inputAccessoryView = toolbar
        zikrCountTextField.inputAccessoryView = toolbar
        
    }
    
    private func setupUI() {
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(40)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.height.equalTo(30) // Set your desired size
            make.bottom.equalTo(titleImageView.snp.bottom).offset(5)
            make.trailing.equalTo(titleImageView.snp.trailing).offset(2)
        }
        
        containerView.addSubview(plusImageView)
        plusImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(14)
            make.height.equalTo(16)
        }

        view.addSubview(groupName)
        groupName.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(25)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        view.addSubview(groupTextField)
        groupTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(groupName.snp.bottom).offset(8)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
        }
        
        view.addSubview(zikrName)
        zikrName.snp.makeConstraints { make in
            make.top.equalTo(groupTextField.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        view.addSubview(zikrTextField)
        zikrTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrName.snp.bottom).offset(8)
            make.width.equalTo(groupTextField.snp.width)
            make.height.equalTo(groupTextField.snp.height)
        }
        
        view.addSubview(zikrInfo)
        zikrInfo.snp.makeConstraints { make in
            make.top.equalTo(zikrTextField.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        view.addSubview(zikrInfoTextField)
        zikrInfoTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrInfo.snp.bottom).offset(8)
            make.width.equalTo(groupTextField.snp.width)
            make.height.equalTo(groupTextField.snp.height)
        }
        
        view.addSubview(zikrCount)
        zikrCount.snp.makeConstraints { make in
            make.top.equalTo(zikrInfoTextField.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        view.addSubview(zikrCountTextField)
        zikrCountTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrCount.snp.bottom).offset(8)
            make.width.equalTo(groupTextField.snp.width)
            make.height.equalTo(groupTextField.snp.height)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-30)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
        }
    }
    
    private func paddingViewForTextField() {
        
        //group name textfield
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        groupTextField.settinPaddingView(paddingView: paddingView)
        
        //zikr name textfield
        let leftview: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        zikrTextField.settinPaddingView(paddingView: leftview)
        
        //zikr info textfield
        let lv: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        zikrInfoTextField.settinPaddingView(paddingView: lv)
        
        //zikr count textfield
        let v: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        zikrCountTextField.settinPaddingView(paddingView: v)
        
    }
    
    private func shadowsForTextField() {
        groupTextField.addShadow()
        zikrTextField.addShadow()
        zikrInfoTextField.addShadow()
        zikrCountTextField.addShadow()
    }
    
    @objc func doneButtonTapped() {
        groupTextField.resignFirstResponder()
        zikrTextField.resignFirstResponder()
        zikrInfoTextField.resignFirstResponder()
        zikrCountTextField.resignFirstResponder()
    }


}
