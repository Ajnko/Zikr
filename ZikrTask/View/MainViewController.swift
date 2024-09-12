//
//  MainViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 22/05/24.
//

import UIKit
import SnapKit
import EMTNeumorphicView

class MainViewController: UIViewController, AddGroupDelegate {
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let segmentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(SegmentCollectionViewCell.self, forCellWithReuseIdentifier: SegmentCollectionViewCell.identifier)
        collectionview.backgroundColor = .darkMode
        collectionview.layer.cornerRadius = 12
        collectionview.isScrollEnabled = false
        return collectionview
    }()
    
    private let dataCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: GroupCollectionViewCell.identifier)
        collectionview.register(PersonalCollectionViewCell.self, forCellWithReuseIdentifier: PersonalCollectionViewCell.identifier)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .darkMode
        button.backgroundColor = .clear
        return button
    }()
    
    let blurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    let myZikrData = ["My Item 1", "My Item 2", "My Item 3", "My Item 1", "My Item 1", "My Item 1", "My Item 1", "My Item 1"]
    
    
    private var selectedSegmentIndex = 0
    
    let getGroupViewModel = GetGroupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zikr"
        
        self.navigationItem.hidesBackButton = true
        
        let leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(logoutButtonTapped))
        leftBarButtonItem.tintColor = .darkMode
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(presentProfileVC))
        rightBarButtonItem.tintColor = .darkMode
        self.navigationItem.setLeftBarButtonItems([leftBarButtonItem], animated: true)
        self.navigationItem.setRightBarButtonItems([rightBarButtonItem], animated: true)
        
        //call methods
        addItemsToView()
        setConstraintToItems()
        configureDelegates()
        
        fetchData()
        groupCreated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataCollectionView.reloadData()
        selectedSegmentIndex = 0
        segmentCollectionView.reloadData()
        dataCollectionView.reloadData()
        
    }
    
    private func configureDelegates() {
        dataCollectionView.delegate = self
        dataCollectionView.dataSource = self
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
    }
    
    
    private func addItemsToView() {
        
        view.addSubview(backgroundImage)
        view.addSubview(segmentCollectionView)
        view.addSubview(dataCollectionView)
        backgroundImage.bringSubviewToFront(segmentCollectionView)
        backgroundImage.bringSubviewToFront(dataCollectionView)
    }
    
    
    private func setConstraintToItems() {
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        segmentCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).multipliedBy(0.25)
            make.width.equalTo(view.snp.width).multipliedBy(0.99)
            make.height.equalTo(view.snp.height).multipliedBy(0.08)
        }
        
        dataCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentCollectionView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        dataCollectionView.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 30
        blurView.snp.makeConstraints{ make in
            make.bottom.equalTo(view.snp.bottom).offset(-45)
            make.right.equalTo(view.snp.right).offset(-15)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        dataCollectionView.bringSubviewToFront(blurView)
        
        blurView.contentView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
    }
    
    func groupCreated() {
        fetchData()
    }
    
    func fetchData() {
        showActivityIndicator()
        getGroupViewModel.fetchGroups { [weak self] result in
            
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                
                switch result {
                case .success(let success):
                    self?.dataCollectionView.reloadData()
                    print("DataCollectionView reloaded")
                case .failure(let error):
                    print("Error fetching groups: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    
    //MARK: - Segment Controller
    
    @objc func addButtonTapped() {
        let vc = AddGroupViewController()
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        
        if let sheet = navVC.sheetPresentationController {
            sheet.preferredCornerRadius = 40
            sheet.detents = [.custom(resolver: { context in
                1 * context.maximumDetentValue
            })]
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
            sheet.accessibilityRespondsToUserInteraction = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        }
        navigationController?.present(navVC, animated: true)
        print("tap")
        
        
    }
    
    @objc func logoutButtonTapped() {
        showAler(title: "Wait", message: "Are you sure you want to logout?")
    }
    
    private func showAler(title: String, message: String) {
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
        // Clear UserDefaults or any other data related to the logged-in user
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        
        // Navigate back to the login screen or perform other necessary actions
        let loginVC = LogInViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }
    
    //MARK: - Present Profile VC
    @objc func presentProfileVC() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    //MARK: - Shows member list for each group
    
    @objc func showMembersList() {
        let vc = MembersListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == segmentCollectionView {
            return 2
        } else if collectionView == dataCollectionView {
            switch selectedSegmentIndex {
            case 0:
                return getGroupViewModel.groups.count
            case 1:
                return 10
            default:
                break
            }
        }
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == segmentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionViewCell.identifier, for: indexPath) as! SegmentCollectionViewCell
            if indexPath.item == 0 {
                cell.configureCell(with: "Groups", image: UIImage(systemName: "person.3")!)
            } else {
                cell.configureCell(with: "Personal", image: UIImage(systemName: "person")!)
            }
            cell.setSelected(indexPath.item == selectedSegmentIndex)
            
            return cell
        } else if collectionView == dataCollectionView {
            if selectedSegmentIndex == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as! GroupCollectionViewCell
                cell.backgroundColor = .clear
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOpacity = 0.5
                cell.layer.shadowOffset = CGSize(width: 0, height: 3)
                cell.layer.shadowRadius = 5
                cell.layer.cornerRadius = 15
                let group = getGroupViewModel.groups[indexPath.item]
                cell.configureCell(with: group)
                cell.groupMembersButton.addTarget(self, action: #selector(showMembersList), for: .touchUpInside)
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonalCollectionViewCell.identifier, for: indexPath) as! PersonalCollectionViewCell
                cell.backgroundColor = .clear
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOpacity = 0.5
                cell.layer.shadowOffset = CGSize(width: 0, height: 3)
                cell.layer.shadowRadius = 5
                cell.layer.cornerRadius = 15
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == segmentCollectionView {
            return CGSize(width: (view.frame.width / 2.07), height: (view.frame.height) / 14)
        } else if collectionView == dataCollectionView {
            return CGSize(width: (view.frame.width) - 40, height: (view.frame.height) / 9)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == segmentCollectionView {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        return UIEdgeInsets()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == segmentCollectionView {
            selectedSegmentIndex = indexPath.item
            segmentCollectionView.reloadData()
            dataCollectionView.reloadData()
        } else {
            if selectedSegmentIndex == 0 {
                let selectedGroup = getGroupViewModel.groups[indexPath.item]
                let vc = GroupZikrCountViewController()
                vc.groupName = selectedGroup.name
                vc.groupPurpose = selectedGroup.purpose
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = PersonalZikrViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


