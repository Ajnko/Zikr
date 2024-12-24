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
        text: "E-mail",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let loginTextFieldBlurView: UIVisualEffectView = {
       let view = UIVisualEffectView()
        return view
    }()
    
    let mailTextField = CustomTextField(
        placeholder: "email",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let phoneNumberLabel = CustomLabel(
        text: "Phone Number",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let phoneNumberContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.backgroundColor = .clear
        return view
    }()

    let phoneNumberTextFieldBlurView: UIVisualEffectView = {
       let view = UIVisualEffectView()
        return view
    }()
    
    let phoneNumberTextField = CustomTextField(
        placeholder: "Phone",
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
    
    let loginButton: UIButton = {
      let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.lightMode, for: .normal)
        button.backgroundColor = .textColor
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 4
        return button
    }()
    
    let createAccountButton: UIButton = {
       let button = UIButton()
        button.setTitle("Create an Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font =  .boldSystemFont(ofSize: 16)
        return button
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.alpha = 0
        
        return view
    }()
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .darkMode
        
        setupUI()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        mailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        offAutoCompletion(isOff: false)
        
    }
    
    private func setupUI() {
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
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
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
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
            make.height.equalTo(blurView.snp.height).multipliedBy(0.1)
        }
        
        containerView.addSubview(loginTextFieldBlurView)
        loginTextFieldBlurView.effect = blurEffect
        loginTextFieldBlurView.clipsToBounds = true
        loginTextFieldBlurView.layer.cornerRadius = 10
        loginTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginTextFieldBlurView.contentView.addSubview(mailTextField)
        mailTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        mailTextField.settinPaddingView(paddingView: paddingView)
        
        blurView.contentView.addSubview(phoneNumberLabel)
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(mailTextField.snp.bottom).offset(18)
            make.left.equalTo(loginLabel.snp.left)
        }
        
        blurView.contentView.addSubview(phoneNumberContainerView)
        phoneNumberContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(10)
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.height)
        }
        
        phoneNumberContainerView.addSubview(phoneNumberTextFieldBlurView)
        phoneNumberTextFieldBlurView.effect = blurEffect
        phoneNumberTextFieldBlurView.clipsToBounds = true
        phoneNumberTextFieldBlurView.layer.cornerRadius = 10
        phoneNumberTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        phoneNumberTextFieldBlurView.contentView.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let lview: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        phoneNumberTextField.settinPaddingView(paddingView: lview)
        
        blurView.contentView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberContainerView.snp.bottom).offset(18)
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
        
        blurView.contentView.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordContainerView.snp.bottom).offset(40)
            make.width.equalTo(mailTextField.snp.width)
            make.height.equalTo(mailTextField.snp.height)
        }
        
        blurView.contentView.addSubview(createAccountButton)
        createAccountButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        createAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(12)
            make.width.equalTo(blurView.snp.width).multipliedBy(0.9)
            make.height.equalTo(blurView.snp.height).multipliedBy(0.1)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc func doneButtonTapped() {
        mailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
    }
    
    @objc private func loginButtonTapped() {
        guard let email = mailTextField.text, !email.isEmpty,
              let phone = phoneNumberTextField.text, !phone.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }
        self.showActivityIndicator()
        loginViewModel.loginUser(email: email, phone: phone, password: password) { [weak self] message in
//            self?.showActivityIndicator()
            DispatchQueue.main.async {
                if message == "Login successful" {
                    let menuVC = MenuViewController()
                    self?.navigationController?.pushViewController(menuVC, animated: true)
                    self?.hideActivityIndicator()
                } else {
                    self?.showAlert(title: "Error", message: message ?? "Login failed due to unknown error.")
                }
            }
        }
    }
    
    // Show activity indicator and blur
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        
        // Animate the blur effect in
        UIView.animate(withDuration: 0.3) {
            self.loadingView.alpha = 1
        }
    }
    
    // Hide activity indicator and blur
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        
        // Animate the blur effect out
        UIView.animate(withDuration: 0.3) {
            self.loadingView.alpha = 0
        }
    }

    
    @objc func createButtonTapped() {
        let vc = CreateAccountViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func offAutoCompletion(isOff: Bool) {
        mailTextField.setAutoCompletion(enabled: isOff)
        passwordTextField.setAutoCompletion(enabled: isOff)
        phoneNumberTextField.setAutoCompletion(enabled: isOff)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func setupPhoneNumberTextField() {
        phoneNumberTextField.keyboardType = .phonePad
        
        let plusMinusAccessoryView = UIToolbar()
        plusMinusAccessoryView.sizeToFit()
        
        let plusButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(insertPlus))
        let minusButton = UIBarButtonItem(title: "-", style: .plain, target: self, action: #selector(insertMinus))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        plusMinusAccessoryView.items = [flexibleSpace, plusButton, minusButton, flexibleSpace]
    }
    
    @objc func insertPlus() {
        phoneNumberTextField.insertText("+")
    }
    
    @objc func insertMinus() {
        phoneNumberTextField.insertText("-")
    }


}

