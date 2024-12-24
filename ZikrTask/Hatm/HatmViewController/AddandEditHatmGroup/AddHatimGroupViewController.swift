//
//  AddHatimGroupViewController.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 29/09/24.
//

import UIKit
import SnapKit

protocol AddHatimGroupDelegate: AnyObject {
    func publicHatmGroupCreated()
}

class AddHatimGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let mainContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let blurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)
    
    let titleImageContainerView: UIView = {
        let view = UIView()
        view.tintColor = .white
        view.layer.cornerRadius = 50
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.backgroundColor = .clear
        return view
    }()
    
    let titleImageBlurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
        return blurview
    }()
    
    let titleImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
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
        view.layer.cornerRadius = 19
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.backgroundColor = .clear
        return view
    }()
    
    let plusImageBlurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
        return blurview
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
    
    let groupNameTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        return view
    }()
    
    let groupNameTextField = CustomTextField(
        placeholder: "Guruh nomi",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let hatimName = CustomLabel(
        text: "Kimga bag'ishlanadi",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let hatimNameTextFieldcontainerView: UIView = {
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
    
    let hatimNameTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        return view
    }()
    
    let hatimNameTextField = CustomTextField(
        placeholder: "Kimga bag'ishlanadi",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let hatimCount = CustomLabel(
        text: "Hatim soni",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let hatimCountTextFieldcontainerView: UIView = {
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
    
    let hatimCountTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        return view
    }()
    
    let hatimCountTextField = CustomTextField(
        placeholder: "Hatim soni",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let addGroupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Guruhni qo'shish", for: .normal)
        button.setTitleColor(.lightMode, for: .normal)
        button.backgroundColor = .darkMode
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 4
        return button
    }()
    
    var containerBottomConstraint: Constraint?
    var activeTextField: UITextField?
    //    private var viewModel = GroupViewModel()
    weak var delegate: AddHatimGroupDelegate?
    
    private var viewModel = CreateHatimGroupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setupUI()
        paddingViewForTextField()
        shadowsForTextField()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        groupNameTextField.inputAccessoryView = toolbar
        hatimNameTextField.inputAccessoryView = toolbar
        hatimCountTextField.inputAccessoryView = toolbar
        
        groupNameTextField.delegate = self
        hatimNameTextField.delegate = self
        hatimCountTextField.delegate = self
        
        setupKeyboardHandling()
        
        //api manager
        let apiService = ApiManager()
        
        let titleImageTap = UITapGestureRecognizer(target: self, action: #selector(selectImageFromGallery))
        titleImageContainerView.addGestureRecognizer(titleImageTap)
        titleImageContainerView.isUserInteractionEnabled = true
        
        let containerViewTap = UITapGestureRecognizer(target: self, action: #selector(selectImageFromGallery))
        containerView.addGestureRecognizer(containerViewTap)
        containerView.isUserInteractionEnabled = true
        
    }
    
    private func setupUI() {
        
        //blur view
        view.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //title image view container view
        blurView.contentView.addSubview(titleImageContainerView)
        titleImageContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(33)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        //title image view blur view
        titleImageContainerView.addSubview(titleImageBlurView)
        titleImageBlurView.effect = blurEffect
        titleImageBlurView.clipsToBounds = true
        titleImageBlurView.layer.cornerRadius = 50
        titleImageBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //title image view
        titleImageBlurView.contentView.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //container view
        blurView.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.height.equalTo(20) // Set your desired size
            make.bottom.equalTo(titleImageContainerView.snp.bottom).offset(-3)
            make.trailing.equalTo(titleImageContainerView.snp.trailing).offset(-3)
        }
        
        //plus image view blur view
        containerView.addSubview(plusImageBlurView)
        plusImageBlurView.effect = blurEffect
        plusImageBlurView.clipsToBounds = true
        plusImageBlurView.layer.cornerRadius = 10
        plusImageBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //plus image view
        plusImageBlurView.contentView.addSubview(plusImageView)
        plusImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //group name label
        blurView.contentView.addSubview(groupName)
        groupName.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        //group name textfield container view
        blurView.contentView.addSubview(groupNameTextFieldcontainerView)
        groupNameTextFieldcontainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(groupName.snp.bottom).offset(8)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.06)
        }
        
        //group name textfield blur view
        groupNameTextFieldcontainerView.addSubview(groupNameTextFieldBlurView)
        groupNameTextFieldBlurView.effect = blurEffect
        groupNameTextFieldBlurView.clipsToBounds = true
        groupNameTextFieldBlurView.layer.cornerRadius = 10
        groupNameTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //group name textfield
        groupNameTextFieldBlurView.contentView.addSubview(groupNameTextField)
        groupNameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //hatim name label
        blurView.contentView.addSubview(hatimName)
        hatimName.snp.makeConstraints { make in
            make.top.equalTo(groupNameTextFieldcontainerView.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        //hatim name textfield container view
        blurView.contentView.addSubview(hatimNameTextFieldcontainerView)
        hatimNameTextFieldcontainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hatimName.snp.bottom).offset(8)
            make.width.equalTo(groupNameTextFieldcontainerView.snp.width)
            make.height.equalTo(groupNameTextFieldcontainerView.snp.height)
        }
        
        //hatim name textfield blur view
        hatimNameTextFieldcontainerView.addSubview(hatimNameTextFieldBlurView)
        hatimNameTextFieldBlurView.effect = blurEffect
        hatimNameTextFieldBlurView.clipsToBounds = true
        hatimNameTextFieldBlurView.layer.cornerRadius = 10
        hatimNameTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //hatim name textfield blur view
        hatimNameTextFieldBlurView.contentView.addSubview(hatimNameTextField)
        hatimNameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //hatim count label
        blurView.contentView.addSubview(hatimCount)
        hatimCount.snp.makeConstraints { make in
            make.top.equalTo(hatimNameTextFieldcontainerView.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        //hatim count textfield container view
        blurView.contentView.addSubview(hatimCountTextFieldcontainerView)
        hatimCountTextFieldcontainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hatimCount.snp.bottom).offset(8)
            make.width.equalTo(groupNameTextFieldcontainerView.snp.width)
            make.height.equalTo(groupNameTextFieldcontainerView.snp.height)
        }
        
        //hatim count textfield blur view
        hatimCountTextFieldcontainerView.addSubview(hatimCountTextFieldBlurView)
        hatimCountTextFieldBlurView.effect = blurEffect
        hatimCountTextFieldBlurView.clipsToBounds = true
        hatimCountTextFieldBlurView.layer.cornerRadius = 10
        hatimCountTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //hatim count textfield
        hatimCountTextFieldBlurView.contentView.addSubview(hatimCountTextField)
        hatimCountTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //save button
        blurView.contentView.addSubview(addGroupButton)
        addGroupButton.addTarget(self, action: #selector(addGroupButtonTapped), for: .touchUpInside)
        addGroupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-40)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
        }
        
    }
    
    @objc private func selectImageFromGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    // UIImagePickerControllerDelegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            // Set the selected image to `titleImageView` or other views as required
            titleImageView.image = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Textfield padding views
    private func paddingViewForTextField() {
        
        //group name textfield
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        groupNameTextField.settinPaddingView(paddingView: paddingView)
        
        //hatim name textfield
        let leftview: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        hatimNameTextField.settinPaddingView(paddingView: leftview)
        
        //hatim count textfield
        let v: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        hatimCountTextField.settinPaddingView(paddingView: v)
        
    }
    
    //MARK: - Keyboard Handling and dismissing when the screen is touched
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Textfield extensions
    
    private func shadowsForTextField() {
        groupNameTextField.addShadow()
        hatimNameTextField.addShadow()
        hatimCountTextField.addShadow()
    }
    
    @objc func doneButtonTapped() {
        groupNameTextField.resignFirstResponder()
        hatimNameTextField.resignFirstResponder()
        hatimCountTextField.resignFirstResponder()
    }
    
    func saveUserId(_ userId: Int) {
        UserDefaults.standard.setValue(userId, forKey: "userId")
    }
    
    //MARK: - Actions in create hatim group
    
    @objc func addGroupButtonTapped() {
        guard let name = groupNameTextField.text, !name.isEmpty,
              let kimga = hatimNameTextField.text, !kimga.isEmpty,
              let hatmSoniString = hatimCountTextField.text, let hatmSoni = Int(hatmSoniString) else {
            showAlert(title: "Validation Error", message: "Please fill all fields.")
            return
        }
        
        viewModel.createGroup(name: name, kimga: kimga, hatmCount: hatmSoni) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    
                    var idGroups = UserDefaults.standard.stringArray(forKey: "AllGroups") ?? []
                    idGroups.append(response.idGroup)
                    UserDefaults.standard.set(idGroups, forKey: "idGroups")
                    print(UserDefaults.standard.stringArray(forKey: "idGroups") ?? [])
                    self.delegate?.publicHatmGroupCreated()
                    
                    self.dismiss(animated: true)
                case .failure(let error):
                    print("Failed to create group: \(error.localizedDescription)")
                }
            }
        }
    }
    
    //MARK: - Create a group and post it using API and saves to CoreData
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

//MARK: - Textfield methods
extension AddHatimGroupViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let activeTextField = activeTextField else { return }
        
        let keyboardHeight = keyboardFrame.height
        let textFieldBottomY = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
        let viewHeight = self.view.frame.height
        
        if textFieldBottomY > viewHeight - keyboardHeight {
            let offset = textFieldBottomY - (viewHeight - keyboardHeight)
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -offset
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}
