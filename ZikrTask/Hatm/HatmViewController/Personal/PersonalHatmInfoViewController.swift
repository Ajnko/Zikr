//
//  PersonalHatmInfoViewController.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 15/11/24.
//

import UIKit
import SnapKit

class PersonalHatmInfoViewController: UIViewController {
    
    //MARK: - Proporties
    
    let blurEffect = UIBlurEffect(style: .extraLight)
    let effect = UIBlurEffect(style: .light)
    let darkEffect = UIBlurEffect(style: .dark)
    
    private var tapGestureRecognizer: UITapGestureRecognizer?
    private var popupMenuView: UIView?
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionview.register(HatmPersonalInfoCollectionViewCell.self, forCellWithReuseIdentifier: HatmPersonalInfoCollectionViewCell.identifier)
        collectionview.register(HatmPersonalInfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HatmPersonalInfoHeaderView.identifier)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.alpha = 0
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view and navigation settings
        title = "Group Hatm"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backButtonTapped))
        setupUI()
        
    }
    
    //MARK: - Set Up UI -
    
    func setupUI() {
        
        //backgroundImage
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //collectionView
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        //activityIndicator
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        loadingView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.1) {
            self.loadingView.alpha = 1
        }
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        
        UIView.animate(withDuration: 0.1) {
            self.loadingView.alpha = 0
        }
    }
    
    
    //MARK: - Actions -
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

//UICollectionViewDataSource
extension PersonalHatmInfoViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HatmPersonalInfoCollectionViewCell.identifier, for: indexPath) as! HatmPersonalInfoCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(view.bounds.width , view.bounds.height / 7)
    }
    
    //HeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HatmPersonalInfoHeaderView.identifier, for: indexPath) as! HatmPersonalInfoHeaderView
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 60)
    }
}


