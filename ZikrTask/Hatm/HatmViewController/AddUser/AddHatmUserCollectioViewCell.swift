//
//  AddUserCollectioViewCell.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 15/11/24.
//

import UIKit
import SnapKit

class AddHatmUserCollectioViewCell: UICollectionViewCell {
    
    static let identifier = "AddUserCollectioViewCell"
    
    let blurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)
    
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
    
    let userNameLabel = CustomLabel(
        text: "User Name",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 15),
        numberOfLines: 0
    )
    let userSurnameLabel = CustomLabel(
        text: "User Surname",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 15),
        numberOfLines: 0
    )
    let userPhoneNumberLabel = CustomLabel(
        text: "+998902544770",
        textColor: .secondaryLabel,
        fontSize: .systemFont(ofSize: 13),
        numberOfLines: 0
    )
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        self.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 15
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurView.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).inset(15)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        blurView.contentView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(18)
            make.left.equalTo(containerView.snp.right).offset(10)
        }
        
        blurView.contentView.addSubview(userSurnameLabel)
        userSurnameLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.left.equalTo(userNameLabel.snp.left)
        }
        
        blurView.contentView.addSubview(userPhoneNumberLabel)
        userPhoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.left.equalTo(userSurnameLabel.snp.right).offset(8)
        }
        
    }
    
    func configureCell(with user: AddHatmUser) {
        userNameLabel.text = "\(user.name)"
        userSurnameLabel.text = "\(user.surname)"
        userPhoneNumberLabel.text = "\(user.phone)"
    }
    
}
