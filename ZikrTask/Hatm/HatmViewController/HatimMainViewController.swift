//
//  HatimMainViewController.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 17/09/24.
//

import UIKit
import SnapKit
import EMTNeumorphicView
import Alamofire

class GroupTapGesture: UITapGestureRecognizer {
    var idGroup: String?
}

class HatimMainViewController: UIViewController, AddHatimGroupDelegate , EditHatimGroupDelegate, GroupHatimInfoDelegate , FinishedHatmGroupDelete , AddPersonalHatmDelegate {
    
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
        collectionview.register(GroupHatimCollectionViewCell.self, forCellWithReuseIdentifier: GroupHatimCollectionViewCell.identifier)
        collectionview.register(PersonalHatimCollectionViewCell.self, forCellWithReuseIdentifier: PersonalHatimCollectionViewCell.identifier)
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
    
    let refreshControl = UIRefreshControl()
    
    var viewModel = HatimGetGroupViewModel()
    var deleteHatmGroupviewModel = DeleteHatmGroupViewModel()
    var mumbersCountArray: [String] = []
    private var selectedSegmentIndex = 0
    var subscribers: [HatmGroupSubscriber] = []
    var countOfMembers: Int = 0
    let groupDetailViewModel = HatmGroupDetailsViewModel()
    private var juzCounts: [String: Int] = [:]
    weak var editDelegate: EditHatimGroupDelegate?
    
    var groupIdToIdDictionary: [String: String] = [:]
    
    private var subscriberCounts: [Int] = []
    
    var currentProgress: Float {
        return UserDefaults.standard.float(forKey: "progressValue")
    }
    
    var currentCount: Int {
        return UserDefaults.standard.integer(forKey: "progressCount")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hatm"
        
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backButtonTapped))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "message.fill"), style: .plain, target: self, action: #selector(presentnaNavigationVC))
        rightBarButtonItem.tintColor = .darkMode
        self.navigationItem.leftBarButtonItem?.tintColor = .darkMode
        self.navigationItem.setRightBarButtonItems([rightBarButtonItem], animated: true)
        
        //call methods
        addItemsToView()
        setConstraintToItems()
        configureDelegates()
        
        fetchPublicGroupDataAndReload()
        getAllData()
        editGroup()
        
        if let savedDictionary = UserDefaults.standard.dictionary(forKey: "groupIdToIdDictionary") as? [String: String] {
            groupIdToIdDictionary = savedDictionary
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        dataCollectionView.refreshControl = refreshControl
    }
    
    func getAllData() {
        selectedSegmentIndex == 0 ? fetchPublicGroupDataAndReload() : fetchPrivateHatmDataAndReload()
    }
    
    @objc private func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl.endRefreshing()
            self.getAllData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadAllData()
    }
    
    private func reloadAllData() {
        dataCollectionView.reloadData()
        segmentCollectionView.reloadData()
    }
    
    func didTapBackButton() {
        if selectedSegmentIndex == 0 {
            fetchPublicGroupDataAndReload()
        } else if selectedSegmentIndex == 1 {
            fetchPrivateHatmDataAndReload()
        }
    }
    
    func didTapDeleteButton() {
        if selectedSegmentIndex == 0 {
            fetchPublicGroupDataAndReload()
        } else if selectedSegmentIndex == 1 {
            fetchPrivateHatmDataAndReload()
        }
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
    
    
    func publicHatmGroupCreated() {
        fetchPublicGroupDataAndReload()
    }
    
    func createPersonalHatmCreated() {
        fetchPrivateHatmDataAndReload()
    }
    
    func editGroup() {
        if selectedSegmentIndex == 0 {
            fetchPublicGroupDataAndReload()
        } else if selectedSegmentIndex == 1 {
            fetchPrivateHatmDataAndReload()
        }
    }
    
    func fetchPublicGroupDataAndReload() {
        showActivityIndicator()
        fetchHatmGroups(fetchFunction: viewModel.fetchPublicHatmGroups)
    }
    
    func fetchPrivateHatmDataAndReload() {
        fetchHatmGroups(fetchFunction: viewModel.fetchPrivateHatmGroups)
    }
    
    func fetchHatmGroups(fetchFunction: (@escaping (Result<[HatmGroupData], Error>) -> Void) -> Void) {
        fetchFunction { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let groups):
                DispatchQueue.main.async {
                    if self.selectedSegmentIndex == 0 {
                        self.viewModel.publicGroups = groups
                    } else if self.selectedSegmentIndex == 1 {
                        self.viewModel.privateGroups = groups
                    }
                    self.juzCounts = [:] // Reset juzCounts for fresh data
                    
                    let groupMapping: [[String: String]] = {
                        if let data = UserDefaults.standard.data(forKey: "groupMapping"),
                           let mapping = try? JSONDecoder().decode([[String: String]].self, from: data) {
                            return mapping
                        }
                        return []
                    }()
                    
                    let getFinishedPoraViewModel = GetFinishedPoraViewModel()
                    let dispatchGroup = DispatchGroup()
                    
                    for group in groups {
                        dispatchGroup.enter()
                        if let poraID = groupMapping.first(where: { $0.keys.contains(group.groupId) })?[group.groupId] {
                            getFinishedPoraViewModel.fetchJuzCount(forPoraID: poraID) { [weak self] juzCount in
                                guard let self = self else { return }
                                DispatchQueue.main.async {
                                    self.juzCounts[group.groupId] = juzCount
                                    if let indexPath = self.indexPathForGroup(groupId: group.groupId) {
                                        self.updateCellAt(indexPath: indexPath, groupId: group.groupId)
                                    }
                                    dispatchGroup.leave()
                                }
                            }
                        } else {
                            // No poraID found; set juzCount to 0
                            DispatchQueue.main.async {
                                self.juzCounts[group.groupId] = 0
                                if let indexPath = self.indexPathForGroup(groupId: group.groupId) {
                                    self.updateCellAt(indexPath: indexPath, groupId: group.groupId)
                                }
                                dispatchGroup.leave()
                            }
                        }
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        self.hideActivityIndicator()
                        self.dataCollectionView.reloadData()
                    }
                }
            case .failure(let error):
                print("Error fetching groups: \(error)")
                self.hideActivityIndicator()
            }
        }
    }
    
    private func indexPathForGroup(groupId: String) -> IndexPath? {
        if selectedSegmentIndex == 0 {
            if let index = viewModel.publicGroups.firstIndex(where: { $0.groupId == groupId }) {
                return IndexPath(item: index, section: 0)
            }
        } else if selectedSegmentIndex == 1 {
            if let index = viewModel.privateGroups.firstIndex(where: { $0.groupId == groupId }) {
                return IndexPath(item: index, section: 0)
            }
        }
        return nil
    }
    
    //
    private func updateCellAt(indexPath: IndexPath, groupId: String) {
        if selectedSegmentIndex == 0 {
            guard let cell = dataCollectionView.cellForItem(at: indexPath) as? GroupHatimCollectionViewCell else { return }
            let group = viewModel.publicGroups[indexPath.item]
            let juzCount = juzCounts[groupId] ?? 0
            cell.hatmCountCell(with: group, juzCount: juzCount)
        } else if selectedSegmentIndex == 1 {
            guard let cell = dataCollectionView.cellForItem(at: indexPath) as? GroupHatimCollectionViewCell else { return }
            let group = viewModel.privateGroups[indexPath.item]
            let juzCount = juzCounts[groupId] ?? 0
            cell.hatmCountCell(with: group, juzCount: juzCount)
        }
    }
    
    
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.1) {
            self.loadingView.alpha = 1
        }
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        
        view.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.1) {
            self.loadingView.alpha = 0
        }
    }
    
    @objc func logoutButtonTapped() {
        showAler(title: "Kuting", message: "Rostan accountingizdan chiqishni xoxlaysizmi?")
    }
    
    private func showAler(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert
        )
        
        let logoutAction = UIAlertAction(title: "Ha", style: .destructive) { _ in
            self.performLogout()
        }
        
        let cancelAction = UIAlertAction(title: "Yo'q", style: .cancel, handler: nil)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    
    private func performLogout() {
        
        removeDataFromUserDefaults()
        
        // Navigate back to the login screen or perform other necessary actions
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
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Present Profile VC
    @objc func presentnaNavigationVC() {
        let notificationVC = HatmNotificationViewController()
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    //MARK: - Shows member list for each group
    
    @objc func showMembersList() {
        let vc = MembersListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addButtonTapped() {
        if selectedSegmentIndex == 0 {
            let vc = AddHatimGroupViewController()
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
        } else if selectedSegmentIndex == 1 {
            let vc = AddPersonalHatmViewController()
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
        }
    }
    
    func editHatmGroup(with groupID: String) {
        
        let vc = EditHatmGroupViewController()
        vc.delegate = self
        vc.groupID = groupID
        
        if selectedSegmentIndex == 0 {
            vc.isPublic = true
        } else if selectedSegmentIndex == 1 {
            vc.isPublic = false
        }
        
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
    }
    
    @objc func enterMemberViewController(_ sender: GroupTapGesture) {
        if let idGroup = sender.idGroup {
            let membersVC = HatimGroupMembersListViewController()
            membersVC.groupId = idGroup
            navigationController?.pushViewController(membersVC, animated: true)
        } else {
            print("idGroup is nil")
        }
    }
    
    //MARK: - Delete group
    func showDeleteGroupAlert(with groupID: String) {
        let alertController = UIAlertController(title: "Guruhni o'chirish", message: "Rostan ham guruhni o'chirishni xoxlaysizmi?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "O'chirish", style: .destructive) { [weak self] _ in
            self?.showActivityIndicator()
            
            self?.deleteHatmGroupviewModel.deleteGroup(with: groupID) { result in
                DispatchQueue.main.async {
                    self?.hideActivityIndicator()
                    switch result {
                    case .success:
                        self?.deleteHatmGroupviewModel.groups.removeAll { $0.groupId == groupID }
                        self?.dataCollectionView.reloadData()
                        self?.showSuccessAlert()
                    case .failure(let error):
                        self?.viewDidLoad()
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Yo'q", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Group deleted successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension HatimMainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == segmentCollectionView {
            return 2
        } else if collectionView == dataCollectionView {
            switch selectedSegmentIndex {
            case 0:
                return viewModel.publicGroups.count
            case 1:
                return viewModel.privateGroups.count
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
                cell.configureCell(with: "Guruh", image: UIImage(systemName: "person.3")!)
            } else {
                cell.configureCell(with: "Shaxsiy", image: UIImage(systemName: "person")!)
            }
            cell.setSelected(indexPath.item == selectedSegmentIndex)
            
            return cell
        } else if collectionView == dataCollectionView {
            if selectedSegmentIndex == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupHatimCollectionViewCell.identifier, for: indexPath) as! GroupHatimCollectionViewCell
                cell.backgroundColor = .clear
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOpacity = 0.5
                cell.layer.shadowOffset = CGSize(width: 0, height: 3)
                cell.layer.shadowRadius = 5
                cell.layer.cornerRadius = 15
                
                let groups = viewModel.publicGroups[indexPath.item]
                let groupId = groups.groupId
                
                let progress = cell.progressView.progress
                let subscriberCount = viewModel.subscriberCounts[groups.groupId]
                let juzCount = juzCounts[groupId] ?? 0
                
                cell.configureCell(with: groups, subscriberCount: subscriberCount, progress: progress)
                cell.hatmCountCell(with: groups, juzCount: juzCount)
                
                let tapGesture = GroupTapGesture(target: self, action: #selector(enterMemberViewController(_:)))
                tapGesture.idGroup = groups.groupId
                cell.groupContainerView.addGestureRecognizer(tapGesture)
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonalHatimCollectionViewCell.identifier, for: indexPath) as! PersonalHatimCollectionViewCell
                cell.backgroundColor = .clear
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOpacity = 0.5
                cell.layer.shadowOffset = CGSize(width: 0, height: 3)
                cell.layer.shadowRadius = 5
                cell.layer.cornerRadius = 15
                
                let groups = viewModel.privateGroups[indexPath.item]
                let groupId = groups.groupId
                
                let progress = UserDefaults.standard.float(forKey: "\(groupId)_progressValue")
                let subscriberCount = viewModel.subscriberCounts[groups.groupId]
                let juzCount = juzCounts[groupId] ?? 0
                
                cell.configureCell(with: groups, subscriberCount: subscriberCount, progress: progress)
                cell.hatmCountCell(with: groups, juzCount: juzCount)
                
                let tapGesture = GroupTapGesture(target: self, action: #selector(enterMemberViewController(_:)))
                tapGesture.idGroup = groups.groupId
                cell.groupContainerView.addGestureRecognizer(tapGesture)
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
                //delegate
                let vc = GroupHatimInfoViewController()
                
                let selectedGroup = viewModel.publicGroups[indexPath.item]
                vc.groupId = selectedGroup.groupId
                vc.delegate = self
                vc.deleteProtocol = self
                print(selectedGroup.groupId)
                
                navigationController?.pushViewController(vc, animated: true)
                
            } else if selectedSegmentIndex == 1 {
                let vc = GroupHatimInfoViewController()
                
                let selectedGroup = viewModel.privateGroups[indexPath.item]
                vc.groupId = selectedGroup.groupId
                vc.delegate = self
                vc.deleteProtocol = self
                print(selectedGroup.groupId)
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    //Edit and Delete
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let groupID: String? = {
            if selectedSegmentIndex == 0 {
                return viewModel.publicGroups[indexPath.item].groupId
            } else if selectedSegmentIndex == 1 {
                return viewModel.privateGroups[indexPath.item].groupId
            }
            return nil
        }()
        
        guard let groupID = groupID else {
            return nil
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            let editAction = UIAction(title: "Tahrirlash",
                                      image: UIImage(systemName: "pencil")) { _ in
                self?.editHatmGroup(with: groupID)
            }
            
            let deleteAction = UIAction(title: "O'chirish",
                                        image: UIImage(systemName: "trash")) { _ in
                self?.showDeleteGroupAlert(with: groupID)
            }
            
            return UIMenu(title: "", options: .displayInline, children: [editAction, deleteAction])
        }
    }
}
