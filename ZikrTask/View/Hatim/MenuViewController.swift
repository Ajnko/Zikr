//
//  MenuViewController.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 17/09/24.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    
    //MARK: - Proporties
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    let units = ["Hatim" , "Zikr"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call methods
        addItemsToView()
        setConstraintToItems()
    }
    
    //Method addItemsToView
    private func addItemsToView() {
        //to view
        view.addSubview(backgroundImage)
        view.addSubview(collectionView)
    }
    
    //Method setConstraintToItems
    private func setConstraintToItems() {
        
        //backgroundImage
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-60)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.2)
            make.width.equalTo(view.snp.width)
        }
    }
}

//UICollectionViewDataSource
extension MenuViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        
        //cell settings
        cell.backgroundColor = AppColor.appBlackColor
        cell.layer.cornerRadius = 10
        cell.textLabel.text = units[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(view.bounds.width / 3, collectionView.bounds.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 45)
    }
    
    //UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            navigationController?.pushViewController(HatimMainViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(MainViewController(), animated: true)
        default:
            break
        }
    }
}
