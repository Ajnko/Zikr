//
//  HatimInfoHeaderView.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 17/09/24.
//

import UIKit
import SnapKit

class HatimInfoHeaderView: UICollectionReusableView {
    
    static let identifier = "HatimInfoHeaderView"
    
    private let blurEffect = UIBlurEffect(style: .extraLight)
    private let progressViewBlurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
        blurview.clipsToBounds = true
        blurview.layer.cornerRadius = 6
        return blurview
    }()
    
    let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.clipsToBounds = true
        progress.layer.cornerRadius = 5
        progress.progress = 0.0
        progress.trackTintColor = .clear
        progress.progressTintColor = .darkMode
        return progress
    }()
    
    let progressLabel = CustomLabel(
        text: "0/30",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 15),
        numberOfLines: 0
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        print(self.bounds.height)
        self.addSubview(progressViewBlurView)
        progressViewBlurView.effect = blurEffect
        progressViewBlurView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(self.snp.height).multipliedBy(0.14)
        }
        
        progressViewBlurView.contentView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(progressLabel)
        progressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressViewBlurView.snp.bottom).offset(10)
        }
    }
    
}
