//
//  ZikrCountViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 23/05/24.
//

import UIKit
import SnapKit

class ZikrCountViewController: UIViewController {
    
    let blurEffect = UIBlurEffect(style: .extraLight)
    let effect = UIBlurEffect(style: .light)
    
    let backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let progressViewBlurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        blurview.clipsToBounds = true
        blurview.layer.cornerRadius = 6
        return blurview
    }()
    
    let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.clipsToBounds = true
        progress.layer.cornerRadius = 5
        progress.progress = 0.6
        progress.trackTintColor = .clear
        progress.progressTintColor = .darkMode
        return progress
    }()
    
    let progressLabel = CustomLabel(
        text: "30.000/70.000", 
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 15),
        numberOfLines: 0
    )
    
    let zikrTextContainerView: UIView = {
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
    
    let zikrTextBlurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        blurview.clipsToBounds = true
        blurview.layer.cornerRadius = 16
        return blurview
    }()
    
    let zikrCounterContainerView: UIView = {
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
    
    let zikrCounterBLurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
         blurview.clipsToBounds = true
         blurview.layer.cornerRadius = 16
         return blurview
    }()
    
    let infoButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.layer.cornerRadius = 13
        button.tintColor = .darkMode
        return button
    }()
    
    let alertButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .darkMode
        return button
    }()
    
    let zikrScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let zikrLabel = CustomLabel(
        text: "بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي وَبِكَ أَرْفَعُهُ إِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا وَإِنْ أرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَبِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي وَبِكَ أَرْفَعُهُ إِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا وَإِنْ أرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ  «Бисмика роббий вазоъту жамбий ва бика арфаъуҳу, ин амсакта нафсий фарҳамҳа ва ин арсалтаҳа фаҳфазҳа бима таҳфазу биҳи ъибадакас солиҳийн»",
        textColor: .textColor,
        fontSize: .boldSystemFont(ofSize: 15),
        numberOfLines: 20
    )
    
    let playButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .darkMode
        return button
    }()
    
    let zikrProgressBlurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
         blurview.clipsToBounds = true
         blurview.layer.cornerRadius = 6
         return blurview
    }()
    
    let zikrProgressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.clipsToBounds = true
        progress.layer.cornerRadius = 5
        progress.progress = 0.6
        progress.trackTintColor = .clear
        progress.progressTintColor = .darkMode
        return progress
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zikr"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backButtonTapped))
        
        setupUI()
        setZikrTextView()
        setZikrCounterView()
    }
    
    func setupUI() {
        
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(progressViewBlurView)
        progressViewBlurView.effect = blurEffect
        progressViewBlurView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).multipliedBy(0.23)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
            make.height.equalTo(view.snp.height).multipliedBy(0.012)
        }
        
        progressViewBlurView.contentView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(progressLabel)
        progressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressViewBlurView.snp.bottom).offset(10)
        }
        
        view.addSubview(zikrTextContainerView)
        zikrTextContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressLabel.snp.bottom).offset(10)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        zikrTextContainerView.addSubview(zikrTextBlurView)
        zikrTextBlurView.effect = effect
        zikrTextBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(zikrCounterContainerView)
        zikrCounterContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-35)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        
        zikrCounterContainerView.addSubview(zikrCounterBLurView)
        zikrCounterBLurView.effect = effect
        zikrCounterBLurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func setZikrTextView() {
        zikrTextBlurView.contentView.addSubview(infoButton)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(zikrTextBlurView.snp.top).offset(8)
            make.right.equalTo(zikrTextBlurView.snp.right).offset(-8)
            make.width.height.equalTo(26)
        }
        
        zikrTextBlurView.contentView.addSubview(alertButton)
        alertButton.snp.makeConstraints { make in
            make.top.equalTo(infoButton.snp.top)
            make.left.equalTo(zikrTextBlurView.snp.left).offset(8)
            make.width.equalTo(infoButton.snp.width)
            make.height.equalTo(infoButton.snp.height)
        }
        
        zikrTextBlurView.contentView.addSubview(zikrScrollView)
        zikrScrollView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(zikrTextBlurView.snp.width).multipliedBy(0.8)
            make.height.equalTo(zikrTextBlurView.snp.height).multipliedBy(0.8)
        }
        
        zikrScrollView.addSubview(zikrLabel)
        zikrLabel.textAlignment = .center
        zikrLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        zikrTextBlurView.contentView.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.top.equalTo(zikrScrollView.snp.bottom).offset(5)
            make.right.equalTo(infoButton.snp.right)
            make.width.equalTo(infoButton.snp.width)
            make.height.equalTo(infoButton.snp.height)
        }
    }
    
    func setZikrCounterView() {
        zikrCounterBLurView.contentView.addSubview(zikrProgressBlurView)
        zikrProgressBlurView.effect = blurEffect
        zikrProgressBlurView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrCounterBLurView.snp.top).offset(8)
            make.width.equalTo(zikrCounterBLurView.snp.width).multipliedBy(0.9)
            make.height.equalTo(zikrCounterBLurView.snp.height).multipliedBy(0.03)
        }
        
        zikrProgressBlurView.contentView.addSubview(zikrProgressView)
        zikrProgressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func infoButtonTapped() {
        let vc = InfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    


}
