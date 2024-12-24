//
//  NotificaionTableViewCell.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 22/11/24.
//

import UIKit
import SnapKit

class NotificationTableViewCell: UITableViewCell {
    static let identifier = "NotificaionTableViewCell"
    
    let blueDot: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
        return view
    }()
    
    let groupNameLabel = CustomLabel(
        text: "Group Name: ",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 18),
        numberOfLines: 0
    )
    
    let messageLabel = CustomLabel(
        text: "Owner is inviting you to joing his group",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 14),
        numberOfLines: 0
    )
    
    let subscribeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkMode
        button.setTitle("Subscribe", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    var onSubscribeButtonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCell()
    }
    
    func setupCell() {
        
        self.addSubview(blueDot)
        blueDot.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(5)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        
        self.addSubview(groupNameLabel)
        groupNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(6)
            make.left.equalTo(blueDot.snp.right).offset(10)
        }
        
        self.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(groupNameLabel.snp.bottom).offset(8)
            make.left.equalTo(groupNameLabel.snp.left)
        }
        
        self.addSubview(subscribeButton)
        subscribeButton.addTarget(self, action: #selector(subscribeButtonTapped), for: .touchUpInside)
        subscribeButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.top)
            make.left.equalTo(messageLabel.snp.right).offset(10)
            make.width.equalTo(95)
            make.height.equalTo(20)
        }
    }
    
    @objc private func subscribeButtonTapped() {
        onSubscribeButtonTapped?()
    }
    
    func configureCell(with data: GetNotificationModel) {
        groupNameLabel.text = data.group?.name ?? "Unknown Group Name"
        blueDot.isHidden = data.isRead
    }
}
