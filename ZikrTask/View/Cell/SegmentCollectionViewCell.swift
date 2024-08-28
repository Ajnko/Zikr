//
//  SegmentCollectionViewCell.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 28/08/24.
//

import UIKit
import SnapKit

class SegmentCollectionViewCell: UICollectionViewCell {
    static let identifier = "Segment Cell"
    
    let titleLabel = CustomLabel(
        text: "",
        textColor: .textColor,
        fontSize: .systemFont(ofSize: 15),
        numberOfLines: 0
    )
    
    let iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 13
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset to default state
        contentView.backgroundColor = .clear
        titleLabel.textColor = .black
        iconImageView.tintColor = .black
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading).offset(-10)
            make.width.height.equalTo(20)
        }
    }
    
    func configureCell(with title: String, image: UIImage) {
        titleLabel.text = title
        iconImageView.image = image.withRenderingMode(.alwaysTemplate)
    }
    
    func setSelected(_ isSelected: Bool) {
        contentView.backgroundColor = isSelected ? UIColor.lightMode : UIColor.darkMode
        titleLabel.textColor = isSelected ? UIColor.textColor : .white
        iconImageView.tintColor = isSelected ? UIColor.textColor : .white
    }
}
