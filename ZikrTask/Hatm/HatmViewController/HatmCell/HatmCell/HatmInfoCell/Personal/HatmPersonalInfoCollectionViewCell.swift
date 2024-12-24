//
//  HatmPersonalInfoCollectionViewCell.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 15/11/24.
//

import UIKit
import SnapKit

class HatmPersonalInfoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "HatmPersonalInfoCollectionViewCell"
    
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
        blurview.layer.cornerRadius = 16
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
        image.image = UIImage(named: "logo")
        image.tintColor = .white
        return image
    }()
    
    let nameLabel = CustomLabel(
        text: "Name",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 15),
        numberOfLines: 0
    )
    
    let surnameLabel = CustomLabel(
        text: "Surname",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 15),
        numberOfLines: 0
    )
    
    let hatimCountLabel = CustomLabel(
        text: "1 pora",
        textColor: .white,
        fontSize: .systemFont(ofSize: 10),
        numberOfLines: 0
    )
    
    let textContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkMode
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 4
        return view
    }()
    
    let selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkMode
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Tanlash"
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.down")
        image.tintColor = .white
        return image
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Boshlash", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.isHidden = true
        return button
    }()
    
    let finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tugatish", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.isHidden = true
        return button
    }()
    
    // MARK: - Initialization
    
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
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
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
            make.top.equalTo(containerView.snp.top)
            make.left.equalTo(containerView.snp.right).offset(12)
        }
        
        hatimTextBlurView.contentView.addSubview(surnameLabel)
        surnameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.left.equalTo(nameLabel.snp.left)
        }
        
        hatimTextBlurView.contentView.addSubview(selectionView)
        selectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.right.equalTo(hatimTextBlurView.snp.right).inset(15)
            make.width.equalTo(hatimTextBlurView.snp.width).multipliedBy(0.24)
            make.height.equalTo(hatimTextBlurView.snp.height).multipliedBy(0.199)
            
        }
        
        selectionView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(selectionView.snp.top).offset(3)
            make.left.equalTo(selectionView.snp.left).inset(7)
        }
        
        selectionView.addSubview(arrowImage)
        arrowImage.snp.makeConstraints { make in
            make.top.equalTo(selectionView.snp.top).offset(1)
            make.right.equalTo(selectionView.snp.right).inset(5)
            make.width.equalTo(15)
            make.height.equalTo(17)
        }
        
        selectionView.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(1)
            make.left.equalTo(label.snp.left)
        }
        
        selectionView.addSubview(finishButton)
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(0)
            make.left.equalTo(startButton.snp.left)
        }
        
        hatimTextBlurView.contentView.addSubview(textContainerView)
        textContainerView.snp.makeConstraints { make in
            make.top.equalTo(surnameLabel.snp.top)
            make.right.equalTo(hatimTextBlurView.snp.right).inset(15)
            make.width.equalTo(hatimTextBlurView.snp.width).multipliedBy(0.24)
            make.height.equalTo(hatimTextBlurView.snp.height).multipliedBy(0.199)
        }
        
        textContainerView.addSubview(hatimCountLabel)
        hatimCountLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}


