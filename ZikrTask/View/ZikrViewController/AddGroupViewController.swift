//
//  AddGroupViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 22/05/24.
//

import UIKit
import SnapKit

protocol AddGroupDelegate: AnyObject {
    func groupCreated()
}


class AddGroupViewController: UIViewController {
    
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
        image.contentMode = .scaleAspectFit
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
    
    let zikrName = CustomLabel(
        text: "Zikr Nomi",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let zikrNameTextFieldcontainerView: UIView = {
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
    
    let zikrNameTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        return view
    }()
    
    let zikrNameTextField = CustomTextField(
        placeholder: "Zikr nomi",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let zikrInfo = CustomLabel(
        text: "Zikr Info",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let zikrInfoTextFieldcontainerView: UIView = {
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
    
    let zikrInfoTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        return view
    }()
    
    let zikrInfoTextField = CustomTextField(
        placeholder: "Zikr info",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let zikrBodyTextFieldLabel = CustomLabel(
        text: "Zikr Body",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let zikrBodyTextFieldcontainerView: UIView = {
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
    
    let zikrBodyTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        return view
    }()
    
    let zikrBodyTextField = CustomTextField(
        placeholder: "Zikr Body",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let zikrCount = CustomLabel(
        text: "Zikr Count",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )
    
    let zikrCountTextFieldcontainerView: UIView = {
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
    
    let zikrCountTextFieldBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        return view
    }()
    
    let zikrCountTextField = CustomTextField(
        placeholder: "Zikr count",
        textColor: .textColor,
        font: .systemFont(ofSize: 15),
        backgroundColor: .clear,
        cornerRadius: 10
    )
    
    let addGroupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Group", for: .normal)
        button.setTitleColor(.lightMode, for: .normal)
        button.backgroundColor = .darkMode
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 4
        return button
    }()
    
    var onDismiss: (() -> Void)?
    
    var containerBottomConstraint: Constraint?
    var activeTextField: UITextField?
    private var viewModel = CreateGroupViewModel()
//    private var zikrViewModel = ZikrViewModel()
    weak var delegate: AddGroupDelegate?
    
    
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
        zikrNameTextField.inputAccessoryView = toolbar
        zikrInfoTextField.inputAccessoryView = toolbar
        zikrCountTextField.inputAccessoryView = toolbar
        
        groupNameTextField.delegate = self
        zikrNameTextField.delegate = self
        zikrInfoTextField.delegate = self
        zikrCountTextField.delegate = self
        
        setupKeyboardHandling()
        
        NotificationCenter.default.post(name: NSNotification.Name("DataUpdated"), object: nil)
        
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
        
        //zikr name label
        blurView.contentView.addSubview(zikrName)
        zikrName.snp.makeConstraints { make in
            make.top.equalTo(groupNameTextFieldcontainerView.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        //zikr name textfield container view
        blurView.contentView.addSubview(zikrNameTextFieldcontainerView)
        zikrNameTextFieldcontainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrName.snp.bottom).offset(8)
            make.width.equalTo(groupNameTextFieldcontainerView.snp.width)
            make.height.equalTo(groupNameTextFieldcontainerView.snp.height)
        }
        
        //zikr name textfield blur view
        zikrNameTextFieldcontainerView.addSubview(zikrNameTextFieldBlurView)
        zikrNameTextFieldBlurView.effect = blurEffect
        zikrNameTextFieldBlurView.clipsToBounds = true
        zikrNameTextFieldBlurView.layer.cornerRadius = 10
        zikrNameTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //zikr name textfield blur view
        zikrNameTextFieldBlurView.contentView.addSubview(zikrNameTextField)
        zikrNameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //zikr info label
        blurView.contentView.addSubview(zikrInfo)
        zikrInfo.snp.makeConstraints { make in
            make.top.equalTo(zikrNameTextFieldcontainerView.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        //zikr info textfield container view
        blurView.contentView.addSubview(zikrInfoTextFieldcontainerView)
        zikrInfoTextFieldcontainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrInfo.snp.bottom).offset(8)
            make.width.equalTo(groupNameTextFieldcontainerView.snp.width)
            make.height.equalTo(groupNameTextFieldcontainerView.snp.height)
        }
        
        //zikr info textfield blur view
        zikrInfoTextFieldcontainerView.addSubview(zikrInfoTextFieldBlurView)
        zikrInfoTextFieldBlurView.effect = blurEffect
        zikrInfoTextFieldBlurView.clipsToBounds = true
        zikrInfoTextFieldBlurView.layer.cornerRadius = 10
        zikrInfoTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //zikr info textfield
        zikrInfoTextFieldBlurView.contentView.addSubview(zikrInfoTextField)
        zikrInfoTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurView.contentView.addSubview(zikrBodyTextFieldLabel)
        zikrBodyTextFieldLabel.snp.makeConstraints { make in
            make.top.equalTo(zikrInfoTextFieldcontainerView.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        blurView.contentView.addSubview(zikrBodyTextFieldcontainerView)
        zikrBodyTextFieldcontainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrBodyTextFieldLabel.snp.bottom).offset(8)
            make.width.equalTo(groupNameTextFieldcontainerView.snp.width)
            make.height.equalTo(groupNameTextFieldcontainerView.snp.height)
        }
        
        zikrBodyTextFieldcontainerView.addSubview(zikrBodyTextFieldBlurView)
        zikrBodyTextFieldBlurView.effect = blurEffect
        zikrBodyTextFieldBlurView.clipsToBounds = true
        zikrBodyTextFieldBlurView.layer.cornerRadius = 10
        zikrBodyTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        zikrBodyTextFieldBlurView.contentView.addSubview(zikrBodyTextField)
        zikrBodyTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //zikr count label
        blurView.contentView.addSubview(zikrCount)
        zikrCount.snp.makeConstraints { make in
            make.top.equalTo(zikrBodyTextFieldcontainerView.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        //zikr count textfield container view
        blurView.contentView.addSubview(zikrCountTextFieldcontainerView)
        zikrCountTextFieldcontainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrCount.snp.bottom).offset(8)
            make.width.equalTo(groupNameTextFieldcontainerView.snp.width)
            make.height.equalTo(groupNameTextFieldcontainerView.snp.height)
        }
        
        //zikr count text field blur view
        zikrCountTextFieldcontainerView.addSubview(zikrCountTextFieldBlurView)
        zikrCountTextFieldBlurView.effect = blurEffect
        zikrCountTextFieldBlurView.clipsToBounds = true
        zikrCountTextFieldBlurView.layer.cornerRadius = 10
        zikrCountTextFieldBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //zikr count textfield
        zikrCountTextFieldBlurView.contentView.addSubview(zikrCountTextField)
        zikrCountTextField.snp.makeConstraints { make in
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
    
    //MARK: - Textfield padding views
    private func paddingViewForTextField() {
        
        //group name textfield
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        groupNameTextField.settinPaddingView(paddingView: paddingView)
        
        //zikr name textfield
        let leftview: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        zikrNameTextField.settinPaddingView(paddingView: leftview)
        
        //zikr info textfield
        let lv: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        zikrInfoTextField.settinPaddingView(paddingView: lv)
        
        //zikr count textfield
        let v: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 15))
        zikrCountTextField.settinPaddingView(paddingView: v)
        
    }
    
    //MARK: - Keyboard Handling and dismissing when the screen is touched
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Textfield extensions
    
    private func shadowsForTextField() {
        groupNameTextField.addShadow()
        zikrNameTextField.addShadow()
        zikrInfoTextField.addShadow()
        zikrCountTextField.addShadow()
    }
    
    @objc func doneButtonTapped() {
        groupNameTextField.resignFirstResponder()
        zikrNameTextField.resignFirstResponder()
        zikrInfoTextField.resignFirstResponder()
        zikrCountTextField.resignFirstResponder()
    }
    
    
    func createGroup() {
        guard let groupName = groupNameTextField.text, !groupName.isEmpty
//              let zikrName = zikrNameTextField.text, !zikrName.isEmpty,
//              let zikrDesc = zikrInfoTextField.text, !zikrDesc.isEmpty,
//              let zikrBody = zikrBodyTextField.text, !zikrBody.isEmpty,
//              let zikrCount = zikrCountTextField.text, let goal = Int(zikrCount)
        else {
            showAlert(title: "Validation Error", message: "Please fill all necessary fields correctly.")
            return
        }
        
        viewModel.createGroup(name: groupName) { [weak self] message in
            DispatchQueue.main.async {
                if let message = message {
//                    print("Group successfully created and group ID successfully saved: \(message)")
                    self?.delegate?.groupCreated()
                    self?.dismiss(animated: true)
                }
            }
        }
        
//        zikrViewModel.createZikr(name: zikrName, desc: zikrDesc, body: zikrBody, goal: goal) { [weak self] message in
//            DispatchQueue.main.async {
//                if let message = message {
//                    self?.dismiss(animated: true)
//                }
//            }
//        }
    }
    
    //MARK: - Create a group and post it using API
    
    @objc func addGroupButtonTapped() {
        createGroup()
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true, completion: nil)
    }
    
    
}

//MARK: - Textfield methods
extension AddGroupViewController: UITextFieldDelegate {
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

extension Notification.Name {
    static let groupCreated = Notification.Name("groupCreated")
}
