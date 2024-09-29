//
//  AddUserViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 01/07/24.
//

import UIKit
import SnapKit

class AddUserViewController: UIViewController {
    
    let blurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)
    
    let userIdLabel = CustomLabel(
        text: "User ID",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let groupNameTextFieldcontainerView: UIView = {
        let view = UIView()
        view.tintColor = .white
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.backgroundColor = .clear
        return view
    }()
    
    let userIdTextFieldBlurView: UIVisualEffectView = {
       let view = UIVisualEffectView()
        return view
    }()
    
    let userIdTextField = CustomTextField(
        placeholder: "Enter User ID ",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let infoButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.layer.cornerRadius = 13
        button.tintColor = .darkMode
        return button
    }()
    
    let addUserButton: UIButton = {
       let button = UIButton()
        button.setTitle("Add User", for: .normal)
        button.setTitleColor(.lightMode, for: .normal)
        button.backgroundColor = .darkMode
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 4
        return button
    }()
    
//    let subscribeViewModel = SubscribeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add User"
        view.backgroundColor = .clear
        
        setupUI()
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        userIdTextField.settinPaddingView(paddingView: paddingView)
        userIdTextField.addShadow()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        userIdTextField.inputAccessoryView = toolbar
    }
    
    func setupUI() {
        view.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurView.contentView.addSubview(userIdLabel)
        userIdLabel.snp.makeConstraints { make in
            make.top.equalTo(blurView.snp.centerY).multipliedBy(0.15)
            make.left.equalTo(blurView.snp.left).offset(20)
        }
        
        blurView.contentView.addSubview(groupNameTextFieldcontainerView)
        groupNameTextFieldcontainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userIdLabel.snp.bottom).offset(8)
            make.width.equalTo(blurView.snp.width).multipliedBy(0.9)
            make.height.equalTo(blurView.snp.height).multipliedBy(0.07)
        }
        
        groupNameTextFieldcontainerView.addSubview(userIdTextFieldBlurView)
        userIdTextFieldBlurView.effect = blurEffect
        userIdTextFieldBlurView.clipsToBounds = true
        userIdTextFieldBlurView.layer.cornerRadius = 10
        userIdTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userIdTextFieldBlurView.contentView.addSubview(userIdTextField)
        userIdTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        userIdTextField.rightView = infoButton
        userIdTextField.rightViewMode = .always
        
        blurView.contentView.addSubview(addUserButton)
        addUserButton.addTarget(self, action: #selector(addUserButtonTapped), for: .touchUpInside)
        addUserButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-40)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
        }
        
    }
    
    @objc func doneButtonTapped() {
        userIdTextField.resignFirstResponder()
    }
    
    @objc func addUserButtonTapped() {
//        guard let userId = userIdTextField.text, !userId.isEmpty else {
//            return
//        }
//        subscribeViewModel.subscribeUserToGroup(userIdText: userId)
//        dismiss(animated: true)
    }
    
}
