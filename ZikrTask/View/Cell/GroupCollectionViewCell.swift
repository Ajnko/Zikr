//
//  MainCollectionViewCell.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 22/05/24.
//

import UIKit
import SnapKit

class GroupCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GroupCollectionViewCell"
    
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
    
    let textContainerView: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.8738430142, green: 0.8458103538, blue: 0.7841303349, alpha: 1)
        view.backgroundColor = .darkMode
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        return view
    }()
    
    let groupNameLabel = CustomLabel(
        text: "Group Name",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 15),
        numberOfLines: 0
    )
    let groupZikrNameLabel = CustomLabel(
        text: "Zikr Name",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 15),
        numberOfLines: 0
    )
    let zikrCountLabel = CustomLabel(
        text: "Count:",
        textColor: .white,
        fontSize: .systemFont(ofSize: 10),
        numberOfLines: 0
    )
    
    let groupContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkMode
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        return view
    }()
    
    let groupMembersButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "person.3.fill"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    let groupLabel = CustomLabel(
        text: "30",
        textColor: .white,
        fontSize: .systemFont(ofSize: 10),
        numberOfLines: 0
    )
    
    let progressBlurView: UIVisualEffectView = {
       let view = UIVisualEffectView()
        return view
    }()
    let progressBlurEffect = UIBlurEffect(style: .extraLight)
    
    let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.clipsToBounds = true
        progress.layer.cornerRadius = 5
        progress.progress = 0.6
        progress.trackTintColor = .clear
        progress.progressTintColor = .darkMode
        return progress
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
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
            make.width.equalTo(14)
            make.height.equalTo(16)
        }
        
        blurView.contentView.addSubview(groupNameLabel)
        groupNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
            make.left.equalTo(containerView.snp.right).offset(10)
        }
        
        blurView.contentView.addSubview(groupZikrNameLabel)
        groupZikrNameLabel.snp.makeConstraints { make in
            make.top.equalTo(groupNameLabel.snp.bottom).offset(10)
            make.left.equalTo(groupNameLabel.snp.left)
        }
        
        blurView.contentView.addSubview(groupContainerView)
        groupContainerView.snp.makeConstraints { make in
            make.top.equalTo(groupNameLabel.snp.top)
            make.right.equalTo(self.snp.right).inset(15)
            make.width.equalTo(self.snp.width).multipliedBy(0.2)
            make.height.equalTo(self.snp.height).multipliedBy(0.293)
        }
        
        groupContainerView.addSubview(groupMembersButton)
        groupMembersButton.addShadow()
        groupMembersButton.snp.makeConstraints { make in
            make.centerY.equalTo(groupContainerView.snp.centerY)
            make.right.equalTo(groupContainerView.snp.centerX).inset(-10)
            make.width.equalTo(groupContainerView.snp.width).multipliedBy(0.37)
            make.height.equalTo(groupContainerView.snp.height).multipliedBy(0.47)
        }
        
        groupContainerView.addSubview(groupLabel)
        groupLabel.snp.makeConstraints { make in
            make.centerY.equalTo(groupContainerView.snp.centerY)
            make.left.equalTo(groupMembersButton.snp.right).inset(-4)
        }
        
        blurView.contentView.addSubview(textContainerView)
        textContainerView.snp.makeConstraints { make in
            make.top.equalTo(groupContainerView.snp.bottom).offset(3)
            make.right.equalTo(groupContainerView.snp.right)
            make.width.equalTo(self.snp.width).multipliedBy(0.29)
            make.height.equalTo(self.snp.height).multipliedBy(0.199)
        }
        
        textContainerView.addSubview(zikrCountLabel)
        zikrCountLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        blurView.contentView.addSubview(progressBlurView)
        progressBlurView.effect = progressBlurEffect
        progressBlurView.clipsToBounds = true
        progressBlurView.layer.cornerRadius = 5
        progressBlurView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.85)
            make.height.equalTo(self.snp.height).multipliedBy(0.07)
        }
        
        progressBlurView.contentView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(with group: Group) {
        groupNameLabel.text = group.name
        zikrCountLabel.text = "Count: \(group.purpose)"
    }
    
}
