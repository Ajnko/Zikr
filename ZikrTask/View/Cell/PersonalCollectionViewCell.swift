//
//  PersonalCollectionViewCell.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 23/05/24.
//

import UIKit
import SnapKit

class PersonalCollectionViewCell: UICollectionViewCell {
    static let identifier = "PersonalCollectionViewCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.tintColor = .white
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        view.backgroundColor = #colorLiteral(red: 0.8738430142, green: 0.8458103538, blue: 0.7841303349, alpha: 1)
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = .white
        return image
    }()
    
    let zikrTitle = CustomLabel(text: "Zikr Title", textColor: .textColor, fontSize: .systemFont(ofSize: 15), numberOfLines: 0)
    let zikrNameLabel = CustomLabel(text: "Zikr Name", textColor: .textColor, fontSize: .systemFont(ofSize: 15), numberOfLines: 0)
    let progressLabel = CustomLabel(text: "30.000 / 70.000", textColor: .textColor, fontSize: .systemFont(ofSize: 10), numberOfLines: 0)
    
    let textContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8738430142, green: 0.8458103538, blue: 0.7841303349, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        return view
    }()
    
    let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.layer.cornerRadius = 10
        progress.progress = 0.7
        progress.trackTintColor = .lightMode
        progress.progressTintColor = #colorLiteral(red: 0.8735236526, green: 0.8339383602, blue: 0.7783764005, alpha: 1)
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
        
        self.addSubview(containerView)
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
        
        self.addSubview(zikrTitle)
        zikrTitle.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(30)
            make.left.equalTo(containerView.snp.right).offset(10)
        }
        
        self.addSubview(zikrNameLabel)
        zikrNameLabel.snp.makeConstraints { make in
            make.top.equalTo(zikrTitle.snp.bottom).offset(10)
            make.left.equalTo(zikrTitle.snp.left)
        }
        
        self.addSubview(textContainerView)
        textContainerView.snp.makeConstraints { make in
            make.top.equalTo(zikrNameLabel.snp.top)
            make.right.equalTo(self.snp.right).inset(15)
            make.width.equalTo(self.snp.width).multipliedBy(0.24)
            make.height.equalTo(self.snp.height).multipliedBy(0.199)
        }
        
        textContainerView.addSubview(progressLabel)
        progressLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        self.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-1)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.981)
            make.height.equalTo(self.snp.height).multipliedBy(0.117)
        }
    }
}
