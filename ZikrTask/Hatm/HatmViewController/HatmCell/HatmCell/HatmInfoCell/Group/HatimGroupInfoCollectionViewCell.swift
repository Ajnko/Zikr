//
//  HatimGroupInfoCollectionViewCell.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 17/09/24.
//

import UIKit
import SnapKit

protocol HatimGroupInfoCollectionViewCellDelegate: AnyObject {
    func selectionButtonTapped(in cell: HatimGroupInfoCollectionViewCell)
    func finishButtonTapped(in cell: HatimGroupInfoCollectionViewCell)
}

class HatimGroupInfoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "HatimGroupInfoCollectionViewCell"
    weak var delegate: HatimGroupInfoCollectionViewCellDelegate?
    
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
    
    var isExpanded = false
    var groupId: String?
    var viewModel: UserProfileViewModel?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        updateProgressInUserDefaults()
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleDropdown))
        selectionView.addGestureRecognizer(tapGesture)
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
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(1)
            make.left.equalTo(label.snp.left)
        }
        
        selectionView.addSubview(finishButton)
        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
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
    
    func configure(with subscriber: HatmGroupSubscriber) {
        nameLabel.text = "\(subscriber.name)"
        surnameLabel.text = "\(subscriber.surname)"
    }
    
    // MARK: - Actions
    
    @objc func selectionButtonTapped() {
        
    }
    
    @objc func dismissDropdown() {
        if isExpanded {
            toggleDropdown()
        }
    }
    
    func enableSelectionView(access: Bool) {
        selectionView.isUserInteractionEnabled = access
    }
    
    
    @objc func toggleDropdown() {
        enableSelectionView(access: true)
        guard selectionView.isUserInteractionEnabled else { return }
        self.isExpanded.toggle()
        
        UIView.animate(withDuration: 0.3) {
            if self.isExpanded {
                self.expandSelectionView()
                
                self.selectionView.snp.remakeConstraints { make in
                    make.top.equalTo(self.nameLabel.snp.top)
                    make.right.equalTo(self.hatimTextBlurView.snp.right).inset(15)
                    if !self.finishButton.isHidden {
                        make.bottom.equalTo(self.finishButton.snp.bottom)
                    } else {
                        make.bottom.equalTo(self.startButton.snp.bottom)
                    }
                    make.width.equalTo(self.hatimTextBlurView.snp.width).multipliedBy(0.24)
                }
            } else {
                self.resetSelectionView()
                self.startButton.isEnabled = false
                self.finishButton.isEnabled = false
            }
            self.invalidateIntrinsicContentSize()
            self.superview?.layoutIfNeeded()
        }
    }
    
    
    private func expandSelectionView() {
        self.selectionView.snp.remakeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.top)
            make.right.equalTo(self.hatimTextBlurView.snp.right).inset(15)
            make.width.equalTo(self.hatimTextBlurView.snp.width).multipliedBy(0.24)
            make.height.equalTo(self.hatimTextBlurView.snp.height).multipliedBy(0.7)
        }
        
        arrowImage.image = UIImage(systemName: "chevron.up")
        textContainerView.isHidden = true
        
        if label.text == startButton.currentTitle {
            showFinishButton()
        } else if label.text == finishButton.currentTitle {
            showStartButton()
        } else {
            startButton.isHidden = false
            finishButton.isHidden = false
            
            startButton.snp.remakeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(5)
                make.left.equalTo(label.snp.left)
            }
            
            finishButton.snp.remakeConstraints { make in
                make.top.equalTo(startButton.snp.bottom).offset(0)
                make.left.equalTo(label.snp.left)
            }
        }
    }
    
    private func setupButtonConstraints(button: UIButton) {
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(1)
            make.left.equalTo(label.snp.left)
        }
        
    }
    
    private func disableSelectionView() {
        UIView.animate(withDuration: 0.3) {
            
            self.selectionView.snp.remakeConstraints { make in
                make.top.equalTo(self.nameLabel.snp.top)
                make.right.equalTo(self.hatimTextBlurView.snp.right).inset(15)
                make.width.equalTo(self.hatimTextBlurView.snp.width).multipliedBy(0.24)
                make.height.equalTo(self.hatimTextBlurView.snp.height).multipliedBy(0.199)
            }
            
            self.invalidateIntrinsicContentSize()
            self.superview?.layoutIfNeeded()
            
            self.selectionView.isUserInteractionEnabled = false
            self.startButton.isEnabled = false
            self.finishButton.isEnabled = false
        }
    }
    
    private func updateProgressInUserDefaults() {
        
        guard let groupId = self.groupId else { return }
        
        let currentProgress = UserDefaults.standard.float(forKey: "\(groupId)_progressValue")
        let updatedProgress = currentProgress + 1.0 / 30.0
        UserDefaults.standard.set(updatedProgress, forKey: "\(groupId)_progressValue")
    }
    
    //Update
    
    @objc func startButtonTapped() {
        // Update the label text and UI state
        label.text = startButton.currentTitle
        showFinishButton()
        delegate?.selectionButtonTapped(in: self)
        // Persist changes
        updateProgressInUserDefaults()
        
        disableSelectionView()
        // Collapse the dropdown
        toggleDropdown()
    }
    
    @objc func finishButtonTapped() {
        // Update the label text and UI state
        label.text = finishButton.currentTitle
        showStartButton()
        delegate?.finishButtonTapped(in: self)
        // Persist changes
        updateProgressInUserDefaults()
        
        disableSelectionView()
        // Collapse the dropdown
        toggleDropdown()
    }
    
    private func showFinishButton() {
        startButton.isHidden = true
        finishButton.isHidden = false
        
        finishButton.snp.remakeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.left.equalTo(label.snp.left)
        }
        finishButton.isEnabled = true
    }
    
    private func showStartButton() {
        finishButton.isHidden = true
        startButton.isHidden = false
        
        startButton.snp.remakeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.left.equalTo(label.snp.left)
        }
        startButton.isEnabled = true
    }
    
    func resetSelectionView() {
        UIView.animate(withDuration: 0.3) {
            self.selectionView.snp.remakeConstraints { make in
                make.top.equalTo(self.nameLabel.snp.top)
                make.right.equalTo(self.hatimTextBlurView.snp.right).inset(15)
                make.width.equalTo(self.hatimTextBlurView.snp.width).multipliedBy(0.24)
                make.height.equalTo(self.hatimTextBlurView.snp.height).multipliedBy(0.199)
            }
            
            self.startButton.isHidden = true
            self.finishButton.isHidden = true
            self.textContainerView.isHidden = false
            self.arrowImage.image = UIImage(systemName: "chevron.down")
        }
    }
    
}

