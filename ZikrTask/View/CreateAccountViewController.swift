//
//  CreateAccountViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 08/07/24.
//

import UIKit
import SnapKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let scrollableContenView: UIView = {
       let view = UIView()
        return view
    }()
    
    let backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let blurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)
    
    let userImageContainerView: UIView = {
        let view = UIView()
        view.tintColor = .white
        view.layer.cornerRadius = 45
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.backgroundColor = .clear
        return view
    }()
    
    let userImageBlurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        return blurview
    }()
        
    let userImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .darkMode
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.5
        image.layer.shadowOffset = CGSize(width: 0, height: 5)
        image.layer.shadowRadius = 4
        image.layer.cornerRadius = 50
        return image
    }()
    
    let userNameLabel = CustomLabel(
        text: "Name",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 16),
        numberOfLines: 1
    )
    
    let userNameTextFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.backgroundColor = .clear
        return view
    }()
    
    let userNameTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
         return view
    }()
    
    let userNameTextField = CustomTextField(
        placeholder: "Name",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let userSurNameLabel = CustomLabel(
        text: "Surname",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 16),
        numberOfLines: 1
    )
    
    let userSurNameTextFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.backgroundColor = .clear
        return view
    }()
    
    let userSurNameTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
         return view
    }()
    
    let userSurNameTextField = CustomTextField(
        placeholder: "Surname",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let passwordLabel = CustomLabel(
        text: "Password",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 16),
        numberOfLines: 1
    )
    
    let passwordTextFieldView: UIView = {
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
        placeholder: "Password",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let mailLabel = CustomLabel(
        text: "E-mail",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 16),
        numberOfLines: 1
    )
    
    let mailTextFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.backgroundColor = .clear
        return view
    }()
    
    let mailTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
         return view
    }()
    
    let mailTextField = CustomTextField(
        placeholder: "E-mail",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let phoneNumberLabel = CustomLabel(
        text: "Phone number",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 16),
        numberOfLines: 1
    )
    
    let phoneNumberTextFieldView: UIView = {
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
        placeholder: "Number",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let createButton: UIButton = {
       let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.lightMode, for: .normal)
        button.backgroundColor = .textColor
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 4
        return button
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    
    var viewModel = CreateUserViewModel()
    var containerBottomConstraint: Constraint?
    let containerView = UIView()
    var activeTextField: UITextField?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Account"
        
        setupUI()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        userNameTextField.inputAccessoryView = toolbar
        userSurNameTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        mailTextField.inputAccessoryView = toolbar
        mailTextField.keyboardType = .emailAddress
        phoneNumberTextField.inputAccessoryView = toolbar
        
        userNameTextField.delegate = self
        userSurNameTextField.delegate = self
        passwordTextField.delegate = self
        mailTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        setupPhoneNumberTextField()
        setupKeyboardHandling()
        offTextFieldAutoCompletion(isOff: false)
        
    }
    
    func setupUI() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.6)
            containerBottomConstraint = make.bottom.equalToSuperview().offset(-200).constraint
        }
        
        containerView.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 15
        blurView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.6)
        }
        
        //MARK:  - user image container view
        blurView.contentView.addSubview(userImageContainerView)
        userImageContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(blurView.snp.top).offset(8)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        //user image blurview
        userImageContainerView.addSubview(userImageBlurView)
        userImageBlurView.effect = blurEffect
        userImageBlurView.clipsToBounds = true
        userImageBlurView.layer.cornerRadius = 40
        userImageBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //user iamgeview
        userImageBlurView.contentView.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //MARK: - User name label & textfield
        blurView.contentView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageContainerView.snp.bottom).offset(10)
            make.left.equalTo(blurView.snp.left).offset(15)
        }
        
        blurView.contentView.addSubview(userNameTextFieldView)
        userNameTextFieldView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.width.equalTo(blurView.snp.width).multipliedBy(0.9)
            make.height.equalTo(blurView.snp.height).multipliedBy(0.065)
        }
        
        userNameTextFieldView.addSubview(userNameTextFieldBlurView)
        userNameTextFieldBlurView.effect = blurEffect
        userNameTextFieldBlurView.clipsToBounds = true
        userNameTextFieldBlurView.layer.cornerRadius = 10
        userNameTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userNameTextFieldBlurView.contentView.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        userNameTextField.settinPaddingView(paddingView: paddingView)
        
        //MARK: - User surname labe & textfield
        blurView.contentView.addSubview(userSurNameLabel)
        userSurNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameTextFieldView.snp.bottom).offset(8)
            make.left.equalTo(userNameLabel.snp.left)
        }
        
        blurView.contentView.addSubview(userSurNameTextFieldView)
        userSurNameTextFieldView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userSurNameLabel.snp.bottom).offset(5)
            make.width.equalTo(userNameTextFieldView.snp.width)
            make.height.equalTo(userNameTextFieldView.snp.height)
        }
        
        userSurNameTextFieldView.addSubview(userSurNameTextFieldBlurView)
        userSurNameTextFieldBlurView.effect = blurEffect
        userSurNameTextFieldBlurView.clipsToBounds = true
        userSurNameTextFieldBlurView.layer.cornerRadius = 10
        userSurNameTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userSurNameTextFieldBlurView.contentView.addSubview(userSurNameTextField)
        userSurNameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let leftView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        userSurNameTextField.settinPaddingView(paddingView: leftView)
        
        //MARK: - Password label & textfield
        
        blurView.contentView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(userSurNameTextFieldView.snp.bottom).offset(8)
            make.left.equalTo(userNameLabel.snp.left)
        }
        
        blurView.contentView.addSubview(passwordTextFieldView)
        passwordTextFieldView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.width.equalTo(userNameTextFieldView.snp.width)
            make.height.equalTo(userNameTextFieldView.snp.height)
        }
        
        passwordTextFieldView.addSubview(passwordTextFieldBlurView)
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
        let lView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        passwordTextField.settinPaddingView(paddingView: lView)
        
        //MARK: - E-mail label & textfield
        
        blurView.contentView.addSubview(mailLabel)
        mailLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextFieldView.snp.bottom).offset(8)
            make.left.equalTo(userNameLabel.snp.left)
        }
        
        blurView.contentView.addSubview(mailTextFieldView)
        mailTextFieldView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mailLabel.snp.bottom).offset(5)
            make.width.equalTo(userNameTextFieldView.snp.width)
            make.height.equalTo(userNameTextFieldView.snp.height)
        }
        
        mailTextFieldView.addSubview(mailTextFieldBlurView)
        mailTextFieldBlurView.effect = blurEffect
        mailTextFieldBlurView.clipsToBounds = true
        mailTextFieldBlurView.layer.cornerRadius = 10
        mailTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mailTextFieldBlurView.contentView.addSubview(mailTextField)
        mailTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let pView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        mailTextField.settinPaddingView(paddingView: pView)
        
        //MARK: - Phone number label & textfield
        
        blurView.contentView.addSubview(phoneNumberLabel)
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(mailTextFieldView.snp.bottom).offset(8)
            make.left.equalTo(userNameLabel.snp.left)
        }
        
        blurView.contentView.addSubview(phoneNumberTextFieldView)
        phoneNumberTextFieldView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(5)
            make.width.equalTo(userNameTextFieldView.snp.width)
            make.height.equalTo(userNameTextFieldView.snp.height)
        }
        
        phoneNumberTextFieldView.addSubview(phoneNumberTextFieldBlurView)
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
        let tView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        phoneNumberTextField.settinPaddingView(paddingView: tView)
        
        blurView.contentView.addSubview(createButton)
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        createButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(blurView.snp.bottom).offset(-15)
            make.width.equalTo(blurView.snp.width).multipliedBy(0.6)
            make.height.equalTo(blurView.snp.height).multipliedBy(0.1)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
    }
    
    //MARK: - Text Field animation method
    
    func offTextFieldAutoCompletion(isOff: Bool) {
        userNameTextField.setAutoCompletion(enabled: isOff)
        userSurNameTextField.setAutoCompletion(enabled: isOff)
        passwordTextField.setAutoCompletion(enabled: isOff)
        mailTextField.setAutoCompletion(enabled: isOff)
        phoneNumberTextField.setAutoCompletion(enabled: isOff)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25

        // Adjust only if the active text field is one of the bottom ones
        if activeTextField == phoneNumberTextField || activeTextField == mailTextField {
            UIView.animate(withDuration: duration) {
                self.containerBottomConstraint?.update(offset: -keyboardHeight)
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        
        UIView.animate(withDuration: duration) {
            self.containerBottomConstraint?.update(offset: -200)
            self.view.layoutIfNeeded()
        }
    }

    
    //MARK: - Create Account Method
    func saveUserId(_ userId: Int) {
        UserDefaults.standard.setValue(userId, forKey: "userId")
    }
    
    func createUser() {
        
        guard let mail = mailTextField.text, !mail.isEmpty,
              let name = userNameTextField.text, !name.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let surname = userSurNameTextField.text, !surname.isEmpty,
              let phone = phoneNumberTextField.text,!phone.isEmpty else {
            showAlert(title: "Validation Error", message: "Please fill all necessary fields correctly.")
            return
        }
        
        viewModel.phone = phone
        viewModel.mail = mail
        viewModel.name = name
        viewModel.surname = surname
        viewModel.password = password
        
        viewModel.createUser { [weak self] result in
            switch result {
            case .success(let userModel):
                print("User Successfully created: \(userModel)")
                
                //save userId to UserDefaults
                self?.saveUserId(userModel.data.userId)
                UserDefaults.standard.set(true, forKey: "isLoggedIn")

                let vc = MainViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
            
        }
    }
    
    
    @objc func createButtonTapped() {
        createUser()
    }
    
    
    private func showAlertAndNavigate(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            let nextViewController = MainViewController() // Replace with your actual next view controller
            self?.navigationController?.pushViewController(nextViewController, animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func doneButtonTapped() {
        userNameTextField.resignFirstResponder()
        userSurNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        mailTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
