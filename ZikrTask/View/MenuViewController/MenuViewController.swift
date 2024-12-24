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
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    let units = ["Hatim", "Zikr"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesBackButton = true

        let leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(logoutButtonTapped))
        leftBarButtonItem.tintColor = .darkMode
        self.navigationItem.setLeftBarButtonItems([leftBarButtonItem], animated: true)
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(userProfileButtonTapped))
        rightBarButtonItem.tintColor = .darkMode
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)

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
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.15)
            make.width.equalTo(view.snp.width).multipliedBy(0.99)
        }
    }
    
    @objc func logoutButtonTapped() {
        showAlert(title: "Wait", message: "Are you sure you want to logout?")
    }
    
    @objc func userProfileButtonTapped() {
        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert
        )
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            self.performLogout()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    
    private func performLogout() {
        
        removeDataFromUserDefaults()
        
        let loginVC = LogInViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }
    
    private func removeDataFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "surname")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "image_url")
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "groupId")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "zikrId")
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
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowRadius = 5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width) / 2.1, height: (view.frame.height) / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
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
