//
//  MainViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 22/05/24.
//

import UIKit
import SnapKit
import EMTNeumorphicView

class MainViewController: UIViewController {
    
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
    
    private let swipingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
    
    let viewModel = GetGroupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Zikr"
        
        self.navigationItem.hidesBackButton = true

        let leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(logoutButtonTapped))
        leftBarButtonItem.tintColor = .darkMode
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: nil)
        rightBarButtonItem.tintColor = .darkMode
        self.navigationItem.setLeftBarButtonItems([leftBarButtonItem], animated: true)
        self.navigationItem.setRightBarButtonItems([rightBarButtonItem], animated: true)
        
        //call methods
        addItemsToView()
        setConstraintToItems()
        configureDelegates()
        
        fetchAndReloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("DataUpdated"), object: nil)

    }
    
    @objc func reloadData() {
        dataCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataCollectionView.reloadData()
        selectedSegmentIndex = 0
        segmentCollectionView.reloadData()
        dataCollectionView.reloadData()
        
        fetchAndReloadData()
    }
    
    private func configureDelegates() {
        dataCollectionView.delegate = self
        dataCollectionView.dataSource = self
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
        swipingCollectionView.delegate = self
        swipingCollectionView.dataSource = self
    }
    
    //Method addItemsToView
    private func addItemsToView() {
        //to view
        view.addSubview(backgroundImage)
        view.addSubview(segmentCollectionView)
        view.addSubview(dataCollectionView)
        view.addSubview(swipingCollectionView)
        backgroundImage.bringSubviewToFront(segmentCollectionView)
        backgroundImage.bringSubviewToFront(dataCollectionView)
    }
    
    //Method setConstraintToItems
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
        
        swipingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentCollectionView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        swipingCollectionView.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 30
        blurView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-45)
            make.right.equalTo(view.snp.right).offset(-15)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        swipingCollectionView.bringSubviewToFront(blurView)
        
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
    
    func fetchAndReloadData() {
        showActivityIndicator()
        
        viewModel.fetchGroups { [weak self] success in
            DispatchQueue.main.async {
                
                self?.hideActivityIndicator()
                
                if success {
                    self?.dataCollectionView.reloadData()
                    self?.segmentCollectionView.reloadData()
                } else {
                    print("Failed to load groups")
                }
            }
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        dataCollectionView.isUserInteractionEnabled = false
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        dataCollectionView.isUserInteractionEnabled = true
    }
    
    
    //MARK: - Segment Controller
    
    @objc func addButtonTapped() {
        let vc = AddGroupViewController()
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
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        let loginVC = LogInViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        
        if let window = UIApplication.shared.windows.first{
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
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
                return viewModel.groups.count
            case 1:
                return 10
            default:
                break
            }
        } else if collectionView == swipingCollectionView {
            return 2
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
                let group = viewModel.groups[indexPath.item]
                cell.configureCell(with: group)
                
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
        } else if collectionView == swipingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == segmentCollectionView {
            return CGSize(width: (view.frame.width / 2.07), height: (view.frame.height) / 14)
        } else if collectionView == dataCollectionView {
            return CGSize(width: (view.frame.width) - 40, height: (view.frame.height) / 9)
        } else if collectionView == swipingCollectionView {
            return CGSize(width: view.frame.width, height: view.frame.height)
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
            swipingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            segmentCollectionView.reloadData()
            dataCollectionView.reloadData()
        } else {
            if selectedSegmentIndex == 0 {
                guard !viewModel.groups.isEmpty && indexPath.item < viewModel.groups.count else {return}
                let vc = GroupZikrCountViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = PersonalZikrViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == swipingCollectionView {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            updateSegmentControllerSelection(for: pageIndex)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == swipingCollectionView {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            updateSegmentControllerSelection(for: pageIndex)
        }
    }
    
    private func updateSegmentControllerSelection(for page: Int) {
        selectedSegmentIndex = page
        segmentCollectionView.reloadData()
        dataCollectionView.reloadData()
    }
}


