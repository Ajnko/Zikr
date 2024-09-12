//
//  SettingsHeaderView.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 25/04/24.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let blurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)
    
    let profileImageView = UIImageView()
    
    let nameLabel = CustomLabel(
        text: "Name",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 18),
        numberOfLines: 0
    )
    
    let surnameLabel = CustomLabel(
        text: "Surname",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 18),
        numberOfLines: 0
    )
    
    let userIdLabel = CustomLabel(
        text: "Your ID:",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 14),
        numberOfLines: 0
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        
//        self.addSubview(blurView)
//        blurView.effect = blurEffect
//        blurView.frame = self.bounds
        
        profileImageView.frame = CGRect(x: 15, y: 20, width: 90, height: 90)
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.layer.cornerRadius = 45
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = .darkMode
        addSubview(profileImageView)
        

        nameLabel.frame = CGRect(x: 135, y: 20, width: 200, height: 30)
        addSubview(nameLabel)
        
        surnameLabel.frame = CGRect(x: 135, y: 60, width: 200, height: 30)
        addSubview(surnameLabel)
        
        userIdLabel.frame = CGRect(x: 135, y: 100, width: 150, height: 20)
        addSubview(userIdLabel)
        
    }
    

    
}
