//
//  ZikrCountViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 23/05/24.
//

import UIKit
import SnapKit
import AVFoundation
import AudioToolbox
import AudioToolbox.AudioServices

class GroupZikrCountViewController: UIViewController {
    
    let blurEffect = UIBlurEffect(style: .extraLight)
    let effect = UIBlurEffect(style: .light)
    let darkEffect = UIBlurEffect(style: .dark)
    
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
        progress.trackTintColor = .clear
        progress.progressTintColor = .darkMode
        return progress
    }()
    
    let zikrCountButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    let zikrCountLabel = CustomLabel(
        text: "",
        textColor: .black,
        fontSize: .boldSystemFont(ofSize: 60),
        numberOfLines: 0
    )
    
    let changeZikrCountButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 10)
        return button
    }()
    
    let zikrAduioContainerView: UIView = {
        let view = UIView()
//        view.tintColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 3
        view.backgroundColor = .clear
        return view
    }()
    
    let zikrAudioBlurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
         blurview.clipsToBounds = true
         blurview.layer.cornerRadius = 16
         return blurview
    }()
    
    let speedButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("1x", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        return button
    }()
    
    let audioSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        return slider
    }()
    
    let repeatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.circlepath"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .clear
        return button
    }()
        
    var count: Int = 0
    var player = AVAudioPlayer()
    var isOn: Bool = true
    
    var maxCount: Int = 33
    var groupName: String?
    var groupPurpose: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = groupName
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backButtonTapped))
        
        setupUI()
        setZikrTextView()
        setZikrCounterView()
        setAudioBlurView()

        
        // Customize thumb image
        let thumbImage = UIImage(systemName: "circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        audioSlider.setThumbImage(thumbImage, for: .normal)
        audioSlider.setThumbImage(thumbImage, for: .highlighted)
        
        // Customize tint color
        audioSlider.minimumTrackTintColor = .darkMode
        audioSlider.maximumTrackTintColor = UIColor.white
        
        progressView.progress = 0.0
        progressLabel.text = groupPurpose
        let purpose = Int(groupPurpose!)
        changeZikrCountButton.setTitle("\(purpose ?? 10)", for: .normal)
        zikrCountLabel.text = "\(count)"
        
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
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        zikrTextContainerView.addSubview(zikrTextBlurView)
        zikrTextBlurView.effect = effect
        zikrTextBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(zikrAduioContainerView)
        zikrAduioContainerView.alpha = 0
        zikrAduioContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrTextContainerView.snp.bottom).offset(7)
            make.width.equalTo(zikrTextContainerView.snp.width)
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
        }
        
        zikrAduioContainerView.addSubview(zikrAudioBlurView)
        zikrAudioBlurView.effect = effect
        zikrAudioBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(zikrCounterContainerView)
        zikrCounterContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-35)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
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
        alertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
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
        playButton.addTarget(self, action: #selector(showAudioPlayer), for: .touchUpInside)
        playButton.snp.makeConstraints { make in
            make.top.equalTo(zikrScrollView.snp.bottom).offset(5)
            make.right.equalTo(infoButton.snp.right)
            make.width.equalTo(infoButton.snp.width)
            make.height.equalTo(infoButton.snp.height)
        }
    }
    
    func setAudioBlurView() {
        
        zikrAudioBlurView.contentView.addSubview(audioSlider)
        audioSlider.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(zikrAudioBlurView.snp.width).multipliedBy(0.6)
            make.height.equalTo(zikrAudioBlurView.snp.height).multipliedBy(0.1)
        }
        
        zikrAudioBlurView.contentView.addSubview(speedButton)
        speedButton.addTarget(self, action: #selector(showPlayBackSpeedOptions), for: .touchUpInside)
        speedButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(zikrAudioBlurView.snp.left).offset(10)
            make.width.equalTo(zikrAudioBlurView.snp.width).multipliedBy(0.1)
            make.height.equalTo(zikrAudioBlurView.snp.height).multipliedBy(0.6)
        }
        
        zikrAudioBlurView.contentView.addSubview(repeatButton)
        repeatButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(zikrAudioBlurView.snp.right).offset(-10)
            make.width.equalTo(speedButton.snp.width)
            make.height.equalTo(speedButton.snp.height)
        }
    }
    
    func setZikrCounterView() {
        zikrCounterBLurView.contentView.addSubview(zikrProgressBlurView)
        zikrProgressBlurView.effect = blurEffect
        zikrProgressBlurView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(zikrCounterBLurView.snp.top).offset(8)
            make.width.equalTo(zikrCounterBLurView.snp.width).multipliedBy(0.9)
            make.height.equalTo(zikrCounterBLurView.snp.height).multipliedBy(0.02)
        }
        
        zikrProgressBlurView.contentView.addSubview(zikrProgressView)
        zikrProgressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        zikrCounterBLurView.contentView.addSubview(changeZikrCountButton)
        changeZikrCountButton.addTarget(self, action: #selector(changeZikrCountButtonTapped), for: .touchUpInside)
        changeZikrCountButton.snp.makeConstraints { make in
            make.top.equalTo(zikrProgressBlurView.snp.bottom).offset(2)
            make.right.equalTo(zikrCounterBLurView.snp.right).offset(-20)
            make.width.equalTo(zikrCounterBLurView.snp.width).multipliedBy(0.1)
            make.height.equalTo(zikrCounterBLurView.snp.height).multipliedBy(0.06)
        }
        
        zikrCounterBLurView.contentView.addSubview(zikrCountButton)
        zikrCountButton.addTarget(self, action: #selector(zikrCountButtonTapped), for: .touchUpInside)
        zikrCountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(changeZikrCountButton.snp.bottom).offset(2)
            make.width.equalTo(zikrCounterBLurView.snp.width).multipliedBy(0.99)
            make.height.equalTo(zikrCounterBLurView.snp.height).multipliedBy(0.9)
        }
        
        zikrCounterBLurView.contentView.addSubview(zikrCountLabel)
        zikrCountLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func infoButtonTapped() {
        let vc = InfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Zikr Count Button Tapped
    
    @objc func zikrCountButtonTapped() {
        count += 1
        
        if count >= Int(groupPurpose!)! {
            
            zikrProgressView.progress = 1.0
            progressView.progress = 1.0
            zikrCountLabel.text = "\(count)"
            // Device vibrates
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            
            // Reset count and progress
            count = 0
            zikrProgressView.progress = 0.0
            progressView.progress = 0.0
        } else {
            // Update progress view and label
            let progress = Float(count) / Float(groupPurpose!)!
            zikrProgressView.progress = progress
            progressView.progress = progress
            zikrCountLabel.text = "\(count)"
        }
    }
   
    func animateLabel() {
        // Scale and fade-in effect
        zikrCountLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        zikrCountLabel.alpha = 0.0
        zikrCountLabel.text = "\(count)"
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.zikrCountLabel.transform = .identity
            self.zikrCountLabel.alpha = 1.0
        }, completion: nil)
    }
    
    //MARK: - Change Zikr count Button Tapped
    
    @objc func changeZikrCountButtonTapped() {
        // Show alert with text field
        let alertController = UIAlertController(title: "Set Maximum Count", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter maximum count"
            textField.keyboardType = .numberPad
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
            if let textField = alertController.textFields?.first,
               let text = textField.text,
               let newMaxCount = Int(text) {
                let purpose = Int(maxCount)
//                self.purpose = newMaxCount
                self.changeZikrCountButton.setTitle("\(purpose)", for: .normal)
                self.zikrProgressView.progress = 0.0
                self.progressView.progress = 0.0
                self.count = 0
                self.zikrCountLabel.text = "\(self.count)"
            }
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Alert Button Tapped
    
    @objc func showAlert() {
        // Create an alert controller
        let alertController = UIAlertController(title: "Choose", message: nil, preferredStyle: .alert)
        
        // Add the "Add Person" action
        let addPersonAction = UIAlertAction(title: "Add Person", style: .default) { [self] _ in
            showAddUserView()
            print("Add Person selected")
        }
        alertController.addAction(addPersonAction)
        
        // Add the "Kunlik zikr miqdor" action
        let dailyZikrAction = UIAlertAction(title: "Kunlik zikr miqdor", style: .default) { [self] _ in
            // Handle the "Kunlik zikr miqdor" action
            changeZikrCountButtonTapped()
            print("Kunlik zikr miqdor selected")
        }
        alertController.addAction(dailyZikrAction)
        
        // Add a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Handle the cancel action
            print("Cancel selected")
        }
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func showAudioPlayer() {
        UIView.animate(withDuration: 0.3) {
            self.zikrAduioContainerView.alpha = 1
        }
    }
    
    @objc func showPlayBackSpeedOptions() {
        let alertController = UIAlertController(title: "Playback speed", message: nil, preferredStyle: .actionSheet)
        
        let speeds: [Float] = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0]
        for speed in speeds {
            let title = speed == 1.0 ? "Normal" : "\(speed)"
            let action = UIAlertAction(title: title, style: .default) { action in
                self.setPlaybackSpeed(speed)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    func setPlaybackSpeed(_ speed: Float) {
        speedButton.setTitle("\(speed)x", for: .normal)
        print("Selected playback speed: \(speed)")
    }
    
    func showAddUserView() {
        let vc = AddUserViewController()
        let navVC = UINavigationController(rootViewController: vc)
        
        if let sheet = navVC.sheetPresentationController {
            sheet.preferredCornerRadius = 40
            sheet.detents = [.custom(resolver: { context in
                0.85 * context.maximumDetentValue
              })]
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
            sheet.accessibilityRespondsToUserInteraction = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        }
        navigationController?.present(navVC, animated: true)
        print("tap")
        
    }
 

}
