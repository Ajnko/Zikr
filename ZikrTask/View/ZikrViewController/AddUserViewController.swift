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
    
    let userPhoneNumber = CustomLabel(
        text: "User Phone Number",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let userImageViewContainer: UIView = {
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
    
    let userPhoneNumberTextfield = CustomTextField(
        placeholder: "Enter phone number ",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let countryCodeLabel = CustomLabel(
        text: "+998",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 12),
        numberOfLines: 0
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
    
    let userDetailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(AddUserCollectioViewCell.self, forCellWithReuseIdentifier: AddUserCollectioViewCell.identifier)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .black
        indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.alpha = 0
        
        return view
    }()
    
    let addUserViewModel = AddUserViewModel()
    let notificationViewModel = NotificationViewModel()
    
    var addGroupId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add User"
        view.backgroundColor = .clear
        
        setupUI()
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        userPhoneNumberTextfield.settinPaddingView(paddingView: paddingView)
        userPhoneNumberTextfield.addShadow()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        userPhoneNumberTextfield.inputAccessoryView = toolbar
        
        userDetailCollectionView.delegate = self
        userDetailCollectionView.dataSource = self
    }
    
    func setupUI() {
        view.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        blurView.contentView.addSubview(userPhoneNumber)
        userPhoneNumber.snp.makeConstraints { make in
            make.top.equalTo(blurView.snp.centerY).multipliedBy(0.15)
            make.left.equalTo(blurView.snp.left).offset(20)
        }
        
        blurView.contentView.addSubview(userImageViewContainer)
        userImageViewContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userPhoneNumber.snp.bottom).offset(8)
            make.width.equalTo(blurView.snp.width).multipliedBy(0.9)
            make.height.equalTo(blurView.snp.height).multipliedBy(0.07)
        }
        
        userImageViewContainer.addSubview(userIdTextFieldBlurView)
        userIdTextFieldBlurView.effect = blurEffect
        userIdTextFieldBlurView.clipsToBounds = true
        userIdTextFieldBlurView.layer.cornerRadius = 10
        userIdTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userIdTextFieldBlurView.contentView.addSubview(userPhoneNumberTextfield)
        userPhoneNumberTextfield.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        userPhoneNumberTextfield.rightView = infoButton
        userPhoneNumberTextfield.rightViewMode = .always
        
        blurView.contentView.addSubview(userDetailCollectionView)
        userDetailCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImageViewContainer.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.height).dividedBy(0.3)
        }
        
        blurView.contentView.addSubview(addUserButton)
        addUserButton.addTarget(self, action: #selector(addUserButtonTapped), for: .touchUpInside)
        addUserButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-35)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
        }
        
    }
    
    func searchUser() {
        guard let phone = userPhoneNumberTextfield.text, !phone.isEmpty else {
            showAlert(title: "Error", message: "Please enter a phone number")
            return
        }
        
        // Fetch user data
        addUserViewModel.fetchUser(phone: phone) { [weak self] in
            self?.showActivityIndicator()
            DispatchQueue.main.async {
                if let errorMessage = self?.addUserViewModel.errorMessage {
                    self?.showAlert(title: "Error", message: "Failed to find user by phone")
                    print(errorMessage) // Handle error (e.g., show alert)

                } else {
                    self?.userDetailCollectionView.reloadData()
                    self?.hideActivityIndicator()
                }
            }
        }
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.hideActivityIndicator()
            self.userDetailCollectionView.reloadData()
            completion?()
        })
        present(alert, animated: true, completion: nil)
    }
    
    @objc func doneButtonTapped() {
        searchUser()
        userPhoneNumberTextfield.resignFirstResponder()
    }
    
    @objc func addUserButtonTapped() {
        guard let receiverId = UserDefaults.standard.string(forKey: "addedUserId") else {
            showAlert(title: "Error", message: "No user to send notification.")
            return
        }
        
        // Replace with the actual groupId you want to send
        let groupId = addGroupId
        
        notificationViewModel.sendNotification(receiverId: receiverId, groupId: groupId!) { [weak self] result in
            self?.showActivityIndicator()
            DispatchQueue.main.async {
                switch result {
                case .success(let notificationResponse):
                    print("Notification sent successfully: \(notificationResponse)")
                    self?.showAlert(title: "Success", message: "Notification sent successfully!")
                    self?.hideActivityIndicator()
                case .failure(let error):
                    print("Failed to send notification: \(error.localizedDescription)")
                    self?.showAlert(title: "Error", message: "Failed to send notification.")
                }
            }
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        

        UIView.animate(withDuration: 0.3) {
            self.loadingView.alpha = 1
        }
    }
    

    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        

        UIView.animate(withDuration: 0.3) {
            self.loadingView.alpha = 0
        }
    }
    
}

extension AddUserViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addUserViewModel.numberOfUsers()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddUserCollectioViewCell.identifier, for: indexPath) as! AddUserCollectioViewCell
        cell.backgroundColor = .clear
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowRadius = 5
        cell.layer.cornerRadius = 25
        
        if let user = addUserViewModel.user {
            cell.configureCell(with: user)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width) - 40, height: (view.frame.height) / 9)
    }
}
