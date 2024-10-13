//
//  HatimGroupMemberListCollectionViewCell.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 03/10/24.
//

import UIKit
import SnapKit

class HatimGroupMemberListTableViewCell: UITableViewCell {
    static let identifier = "HatimGroupMemberListTableViewCell"
    
    let blurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)

    let membersNameLabel = CustomLabel(
        text: "John Wick",
        textColor: .darkMode,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 1
    )

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCell()
    }
    
    func setupCell() {
        self.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurView.contentView.addSubview(membersNameLabel)
        membersNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(blurView.snp.left).offset(15)
        }
    }

}
