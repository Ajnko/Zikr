//
//  ViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 21/05/24.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    
    let backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let titleImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
//        image.backgroundColor = .lightMode
//        image.layer.shadowColor = UIColor.black.cgColor
//        image.layer.shadowOpacity = 0.5
//        image.layer.shadowOffset = CGSize(width: 0, height: 5)
//        image.layer.shadowRadius = 4
//        image.layer.cornerRadius = 70
        return image
    }()
    
    let containerView: UIView = {
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
    
    let blurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)
    
    let titleLabel = CustomLabel(
        text: "Zikr",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 25),
        numberOfLines: 0
    )
    
    let loginLabel = CustomLabel(
        text: "Login",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let loginTextFieldBlurView: UIVisualEffectView = {
       let view = UIVisualEffectView()
        return view
    }()
    
    let loginTextField = CustomTextField(
        placeholder: "email",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let passwordLabel = CustomLabel(
        text: "Password",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let passwordContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.backgroundColor = .clear
        return view
    }()

    let passwordTextFieldBlurView: UIVisualEffectView = {
       let view = UIVisualEffectView()
        return view
    }()
    
    let passwordTextField = CustomTextField(
        placeholder: "password",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let nextButton: UIButton = {
      let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.lightMode, for: .normal)
        button.backgroundColor = .textColor
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = #colorLiteral(red: 0.8452333808, green: 0.8105810285, blue: 0.7374964356, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .darkMode
        
        setupUI()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        loginTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        
    }
    
    private func setupUI() {
        
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(60)
            make.width.equalTo(140)
            make.height.equalTo(140)
        }
        backgroundImage.bringSubviewToFront(titleImageView)
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleImageView.snp.bottom).offset(15)
        }
        
        
        view.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 15
        blurView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        blurView.contentView.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(blurView.snp.top).offset(20)
            make.left.equalTo(blurView.snp.left).offset(15)
        }
        
        blurView.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginLabel.snp.bottom).offset(10)
            make.width.equalTo(blurView.snp.width).multipliedBy(0.9)
            make.height.equalTo(blurView.snp.height).multipliedBy(0.13)
        }
        
        containerView.addSubview(loginTextFieldBlurView)
        loginTextFieldBlurView.effect = blurEffect
        loginTextFieldBlurView.clipsToBounds = true
        loginTextFieldBlurView.layer.cornerRadius = 10
        loginTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginTextFieldBlurView.contentView.addSubview(loginTextField)
        loginTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        loginTextField.settinPaddingView(paddingView: paddingView)
        
        blurView.contentView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(18)
            make.left.equalTo(loginLabel.snp.left)
        }
        
        blurView.contentView.addSubview(passwordContainerView)
        passwordContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.height)
        }
        
        passwordContainerView.addSubview(passwordTextFieldBlurView)
        passwordTextFieldBlurView.effect = blurEffect
        passwordTextFieldBlurView.clipsToBounds = true
        passwordTextFieldBlurView.layer.cornerRadius = 10
        passwordTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        passwordTextFieldBlurView.contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let leftview: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        passwordTextField.settinPaddingView(paddingView: leftview)
        
        blurView.contentView.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordContainerView.snp.bottom).offset(40)
            make.width.equalTo(loginTextField.snp.width)
            make.height.equalTo(loginTextField.snp.height)
        }
    }
    
    @objc func doneButtonTapped() {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @objc func nextButtonTapped() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    


}

