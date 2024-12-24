//
//  MainViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 22/05/24.
//

import UIKit
import SnapKit
import EMTNeumorphicView

class MainViewController: UIViewController, AddGroupDelegate, ZikrCountUpdate {
    
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
    
    let blurEffect = UIBlurEffect(style: .light)
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .black
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
    
    let myZikrData = ["My Item 1", "My Item 2", "My Item 3", "My Item 1", "My Item 1", "My Item 1", "My Item 1", "My Item 1"]
    var groups: [Group] = []
    
    
    private var selectedSegmentIndex = 0
    
    var viewModel = GetGroupAndZikrViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zikr"
        self.navigationItem.hidesBackButton = false
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "message.fill"), style: .plain, target: self, action: #selector(showNotificationVC))
        rightBarButtonItem.tintColor = .darkMode
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        
        //call methods
        addItemsToView()
        setConstraintToItems()
        configureDelegates()
        
        fetchGroups()
        groupCreated()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataCollectionView), name: NSNotification.Name("ZikrCountUpdated"), object: nil)

    }
    
    @objc func reloadDataCollectionView() {
        // Reload your DataCollectionView data here
        self.dataCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedSegmentIndex = 0
        segmentCollectionView.reloadData()
        groupCreated()
        dataCollectionView.reloadData()
        groupCreated()
        
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
        view.addSubview(loadingView)
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
        
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
    }
    
    //MARK: - Protocol Methods
    
    private func loadCountsFromUserDefaults() {
        for index in 0..<groups.count {
            var group = groups[index]
            group.totalZikrCount = 0 // Reset count to avoid double counting
            
            // Loop through each ZikrProgress for this group
            for i in 0..<group.zikrProgress.count {
                let zikrProgress = group.zikrProgress[i]
                let key = "\(group.groupId)_\(zikrProgress.zikrName)_count"
                let count = UserDefaults.standard.integer(forKey: key)
                
                // Update ZikrProgress count
                group.zikrProgress[i].zikrCount = count
                
                // Sum up to calculate totalZikrCount
                group.totalZikrCount += count
            }
            
            groups[index] = group // Update the group in the array
        }
        dataCollectionView.reloadData() // Reload the collection view to reflect updated counts
    }


    
    func groupCreated() {
        fetchGroups()

    }
    
    func updateZikrCount() {
//        self.dataCollectionView.reloadData()
    }
    
    //MARK: - Fetch Created Groups and Zikrs
    
    func fetchGroups() {
        showActivityIndicator()
        viewModel.fetchGroupsAndZikrs { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                
                if let error = errorMessage {
                } else {
                    self?.dataCollectionView.reloadData()
                }
            }
        }
    }
    
    // Show activity indicator and blur
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        

        UIView.animate(withDuration: 0.3) {
            self.loadingView.alpha = 1
        }
    }
    

    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        

        UIView.animate(withDuration: 0.3) {
            self.loadingView.alpha = 0
        }
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
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert
        )
        present(alertController, animated: true)
        
    }
    
    @objc func showNotificationVC() {
        let notificationVC = NotificationsViewController()
        self.navigationController?.pushViewController(notificationVC, animated: true)
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
                return viewModel.numberOfGroups()
            case 1:
                return 10
            default:
                break
            }
        }
        return 10
    }
    
    func incrementZikrCount(for groupId: String, zikrId: String) {
        // Create the key for UserDefaults
        let countKey = "\(groupId)_\(zikrId)_count"
        
        // Retrieve the current zikr count from UserDefaults
        var currentCount = UserDefaults.standard.integer(forKey: countKey)
        
        // Increment the count
        currentCount += 1
        
        // Save the updated count back to UserDefaults
        UserDefaults.standard.set(currentCount, forKey: countKey)
        
        // Optionally, print the current count to debug
        print("Updated Zikr count for \(countKey): \(currentCount)")
    }

    // Call this function whenever you need to update the zikr count
    func updateZikrCount(for groupId: String, zikrId: String) {
        incrementZikrCount(for: groupId, zikrId: zikrId)
        
        // Optionally, you can refresh the UI or handle any additional logic after updating the count
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

                // Fetch group data
                let group = viewModel.group(at: indexPath.row)

                // Fetch zikr data for the group
                if let zikrs = viewModel.zikrsByGroupId[group.groupId], let zikr = zikrs.first {
                    
                    // Directly use groupId and zikrId assuming they are non-optional
                    let groupId = group.groupId
                    let zikrId = zikr.id

                    // Ensure we have valid IDs to create the key
                    if !groupId.isEmpty && !zikrId.isEmpty {
                        let countKey = "\(groupId)_\(zikrId)_count"
                        let userSpecificCount = UserDefaults.standard.integer(forKey: countKey)
                        print("Retrieved user-specific count from UserDefaults for key \(countKey): \(userSpecificCount)")

                        // Configure the cell with group, zikr, and user-specific count
                        cell.configureCell(with: group, and: zikr, userSpecificCount: userSpecificCount)
                    } else {
                        print("Error: groupId or zikrId is empty")
                        cell.configureCell(with: group, and: nil, userSpecificCount: 0)
                    }
                } else {
                    cell.configureCell(with: group, and: nil, userSpecificCount: 0) // Configure without zikr if not found
                }

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

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        if collectionView == dataCollectionView {
            let group = viewModel.group(at: indexPath.row)
            let zikrs = viewModel.zikrsForGroup(at: indexPath.row) // Get the zikrs for the selected group
            
            // Assuming you want to delete the first zikr in the list, if available
            let zikrId = zikrs.first?.id // Replace with your zikr's identifier
            
            let deleteAction = UIAction(title: "Delete Group and Zikr", image: UIImage(systemName: "trash")) { [weak self] _ in
                guard let self = self else { return }
                self.confirmDelete(groupId: group.groupId, zikrId: zikrId)
            }

            let menu = UIMenu(title: "", children: [deleteAction])
            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in menu })
        }
        return nil
    }
    
    // Confirmation alert for deleting both group and zikr
    private func confirmDelete(groupId: String, zikrId: String?) {
        let alert = UIAlertController(title: "Delete Group and Zikr", message: "Are you sure you want to delete this group and its zikr?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            // Delete Zikr first, then delete Group
            if let zikrId = zikrId {
                ApiManager.shared.deleteZikr(withId: zikrId) { result in
                    switch result {
                    case .success:
                        print("Zikr deleted successfully")
                        // Now delete the group
                        ApiManager.shared.deleteGroup(withId: groupId) { result in
                            switch result {
                            case .success:
                                print("Group deleted successfully")
                                self?.fetchGroups() // Reload the data after deletion
                            case .failure(let error):
                                print("Failed to delete group: \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        print("Failed to delete zikr: \(error.localizedDescription)")
                    }
                }
            } else {
                // If there is no zikrId, just delete the group
                ApiManager.shared.deleteGroup(withId: groupId) { result in
                    switch result {
                    case .success:
                        print("Group deleted successfully")
                        self?.fetchGroups() // Reload the data after deletion
                    case .failure(let error):
                        print("Failed to delete group: \(error.localizedDescription)")
                    }
                }
            }
        }))
        present(alert, animated: true, completion: nil)
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
                let selectedGroup = viewModel.group(at: indexPath.row)
                
                // Retrieve the first zikr for the selected group
                if let zikrs = viewModel.zikrsByGroupId[selectedGroup.groupId], let selectedZikr = zikrs.first {
                    UserDefaults.standard.set(selectedGroup.groupId, forKey: "groupId")
                    UserDefaults.standard.set(selectedZikr.id, forKey: "zikrId")
                    
                    let vc = GroupZikrCountViewController()
                    vc.zikrUpdateCountDelegate = self
                    vc.groupName = selectedGroup.groupName
                    vc.groupPurpose = "\(selectedZikr.goal)"
                    vc.groupId = selectedGroup.groupId
                    vc.zikrId = selectedZikr.id
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let vc = PersonalZikrViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
