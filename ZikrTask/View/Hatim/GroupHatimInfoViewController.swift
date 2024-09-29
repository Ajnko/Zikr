//
//  GroupHatimViewController.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 17/09/24.
//

import UIKit
import SnapKit

class GroupHatimInfoViewController: UIViewController, HatimGroupInfoCollectionViewCellDelegate {
    
    //MARK: - Proporties
    
    let blurEffect = UIBlurEffect(style: .extraLight)
    let effect = UIBlurEffect(style: .light)
    let darkEffect = UIBlurEffect(style: .dark)
    
    private var headerView: HatimInfoHeaderView?
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
        
        collectionview.register(HatimGroupInfoCollectionViewCell.self, forCellWithReuseIdentifier: HatimGroupInfoCollectionViewCell.identifier)
        collectionview.register(HatimInfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HatimInfoHeaderView.identifier)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view and navigation settings
        title = "Group Hatim"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backButtonTapped))
        setupUI()
        
        //gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        view.addGestureRecognizer(tapGesture)
    }
    
    //Method that setupUI
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
    }
    
    //MARK: - Actions
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapOutside() {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in visibleIndexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? HatimGroupInfoCollectionViewCell {
                if cell.isExpanded {
                    cell.resetSelectionView()
                }
            }
        }
    }
    
    //MARK: HatimGroupInfoCollectionViewCellDelegate
    func selectionButtonTapped(in cell: HatimGroupInfoCollectionViewCell) {
    }
    
    func finishButtonTapped(in cell: HatimGroupInfoCollectionViewCell) {
        guard let headerView = headerView else {
            print("HeaderView is nil")
            return
        }
        
        let currentProgress = headerView.progressView.progress
        let updatedProgress = currentProgress + 1.0 / 30.0
        headerView.progressView.setProgress(updatedProgress, animated: true)
        
        let currentCount = Int(headerView.progressLabel.text?.components(separatedBy: "/").first ?? "0") ?? 0
        let updatedCount = currentCount + 1
        headerView.progressLabel.text = "\(updatedCount)/30"
    }
}

//UICollectionViewDataSource
extension GroupHatimInfoViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HatimGroupInfoCollectionViewCell.identifier, for: indexPath) as! HatimGroupInfoCollectionViewCell
        let poraNumber = indexPath.row + 1
        cell.hatimCountLabel.text = "\(poraNumber) pora"
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(view.bounds.width , view.bounds.height / 7)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in visibleIndexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? HatimGroupInfoCollectionViewCell {
                if cell.isExpanded {
                    cell.resetSelectionView()
                }
            }
        }
    }
    //HeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HatimInfoHeaderView.identifier, for: indexPath) as! HatimInfoHeaderView
        self.headerView = headerView
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 60)
    }
}

