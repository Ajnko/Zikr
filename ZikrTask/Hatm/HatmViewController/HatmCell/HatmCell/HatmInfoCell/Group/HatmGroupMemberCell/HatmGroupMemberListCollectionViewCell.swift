//
//  HatmGroupMemberListCollectionViewCell.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 03/11/24.
//

import UIKit
import SnapKit

class HatmGroupMemberListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "HatmGroupMemberListCollectionViewCell"
    
    let hatimTextContainerView: UIView = {
        let view = UIView()
        view.tintColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 3
        view.backgroundColor = .clear
        return view
    }()
    
    let hatimTextBlurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
        blurview.clipsToBounds = true
        blurview.layer.cornerRadius = 12
        return blurview
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.tintColor = .white
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.backgroundColor = .darkMode
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = .white
        return image
    }()
    
    let nameLabel = CustomLabel(
        text: "Faxriddin",
        textColor: .textColor,
        fontSize: UIFont.systemFont(ofSize: 14, weight: .medium),
        numberOfLines: 0
    )
    
    let surnameLabel = CustomLabel(
        text: "Mo'ydinxonov",
        textColor: .textColor,
        fontSize: UIFont.systemFont(ofSize: 15, weight: .medium),
        numberOfLines: 0
    )
    
    let leaveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .textColor
        return button
    }()
    
    let exitView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 8
        view.isHidden = true
        return view
    }()
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        self.addSubview(hatimTextContainerView)
        hatimTextContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.98)
            make.height.equalTo(self.snp.height).multipliedBy(0.9)
        }
        
        hatimTextContainerView.addSubview(hatimTextBlurView)
        hatimTextBlurView.effect = UIBlurEffect(style: .light)
        hatimTextBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hatimTextBlurView.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(hatimTextBlurView.snp.left).inset(15)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(14)
            make.height.equalTo(16)
        }
        
        hatimTextBlurView.contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(5)
            make.left.equalTo(containerView.snp.right).offset(12)
        }
        
        hatimTextBlurView.contentView.addSubview(surnameLabel)
        surnameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalTo(nameLabel.snp.left)
        }
        
        hatimTextBlurView.contentView.addSubview(leaveButton)
        leaveButton.addTarget(self, action: #selector(leaveButtonTapped), for: .touchUpInside)
        leaveButton.snp.makeConstraints { make in
            make.right.equalTo(hatimTextBlurView.snp.right).offset(-15)
            make.centerY.equalTo(hatimTextBlurView.snp.centerY)
        }
        
    }
    
    func configure(with subscriber: HatmGroupSubscriber) {
        nameLabel.text = "\(subscriber.name)"
        surnameLabel.text = "\(subscriber.surname)"
    }
    
    //MARK: - Action
    
    @objc func leaveButtonTapped() {
        
    }
}
//0443f576-5712-472b-8731-bfa62f55128c
