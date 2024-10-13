//
//  PersonalHatimCollectionViewCell.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 17/09/24.
//

import UIKit
import SnapKit

class PersonalHatimCollectionViewCell: UICollectionViewCell {
    static let identifier = "PersonalHatimCollectionViewCell"
    
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
        //        view.backgroundColor = #colorLiteral(red: 0.8738430142, green: 0.8458103538, blue: 0.7841303349, alpha: 1)
        view.backgroundColor = .darkMode
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = .white
        return image
    }()
    
    let hatimTitle = CustomLabel(
        text: "Hatim Title",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 15),
        numberOfLines: 0
    )
    let hatimNameLabel = CustomLabel(
        text: "Hatim Name",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 15),
        numberOfLines: 0
    )
    let progressLabel = CustomLabel(
        text: "1/30",
        textColor: .white,
        fontSize: .systemFont(ofSize: 10),
        numberOfLines: 0
    )
    
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
    
    let progressBlurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        return view
    }()
    let progressBlurEffect = UIBlurEffect(style: .extraLight)
    
    let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.progress = 0.7
        progress.trackTintColor = .clear
        //        progress.progressTintColor = #colorLiteral(red: 0.8735236526, green: 0.8339383602, blue: 0.7783764005, alpha: 1)
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
        
        blurView.contentView.addSubview(hatimTitle)
        hatimTitle.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(30)
            make.left.equalTo(containerView.snp.right).offset(10)
        }
        
        blurView.contentView.addSubview(hatimNameLabel)
        hatimNameLabel.snp.makeConstraints { make in
            make.top.equalTo(hatimTitle.snp.bottom).offset(10)
            make.left.equalTo(hatimTitle.snp.left)
        }
        
        blurView.contentView.addSubview(textContainerView)
        textContainerView.snp.makeConstraints { make in
            make.top.equalTo(hatimNameLabel.snp.top)
            make.right.equalTo(self.snp.right).inset(15)
            make.width.equalTo(self.snp.width).multipliedBy(0.24)
            make.height.equalTo(self.snp.height).multipliedBy(0.199)
        }
        
        textContainerView.addSubview(progressLabel)
        progressLabel.snp.makeConstraints { make in
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
}
