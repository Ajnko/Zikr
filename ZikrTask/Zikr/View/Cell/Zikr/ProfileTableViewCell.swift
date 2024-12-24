//
//  ProfileTableViewCell.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 12/09/24.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    static let identifier = "Profile Cell"
    
    let blurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)
    
    let profileDetailsLabel = CustomLabel(
        text: "name", 
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 0
    )

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCell()
    }
    
    private func setupCell() {
        
//        self.addSubview(blurView)
//        blurView.effect = blurEffect
//        blurView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        self.addSubview(profileDetailsLabel)
        profileDetailsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(15)
        }
    }

}
