//
//  HatimGroupMembersListViewController.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 03/10/24.
//

import UIKit
import SnapKit

class HatimGroupMembersListViewController: UIViewController {
    
    //MARK: - Proporties
    
    var groupId: String?
    var countOfMembers: Int = 0
    var subscribers: [HatmGroupSubscriber] = []
    let viewModel = HatmGroupDetailsViewModel()
    
    let blurEffect = UIBlurEffect(style: .extraLight)
    let effect = UIBlurEffect(style: .light)
    let darkEffect = UIBlurEffect(style: .dark)
    
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
        
        collectionview.register(HatmGroupMemberListCollectionViewCell.self, forCellWithReuseIdentifier: HatmGroupMemberListCollectionViewCell.identifier)
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
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view and navigation settings
        title = "Hatm Guruh A'zolari"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .darkMode
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill.badge.plus"), style: .plain, target: self, action: #selector(presentBottomSheet))
        rightBarButtonItem.tintColor = .darkMode
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        
        setupUI()
        fetchFollowers()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl.endRefreshing()
            self.fetchFollowers()
        }
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
    
    func fetchFollowers() {
        
        guard let groupId = groupId else { return }
        
        showActivityIndicator()
        viewModel.fetchHatmGroupDetails(idGroup: groupId) { [weak self] result in
            switch result {
            case .success(let detailsData):
                self?.subscribers = detailsData.subscribers
                self?.countOfMembers = self?.subscribers.count ?? 0
                print("\(self?.countOfMembers) Member")
                DispatchQueue.main.async {
                    self?.hideActivityIndicator()
                    self?.collectionView.reloadData()
                    
                }
            case .failure(let error):
                print("Failed to fetch group details: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Actions -
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func presentBottomSheet() {
        let vc = AddUserViewController()
        vc.addGroupId = groupId
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

//UICollectionViewDataSource
extension HatimGroupMembersListViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subscribers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HatmGroupMemberListCollectionViewCell.identifier, for: indexPath) as! HatmGroupMemberListCollectionViewCell
        cell.backgroundColor = .clear
        let subscriber = subscribers[indexPath.row]
        cell.configure(with: subscriber)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(view.bounds.width * 0.94, view.bounds.height * 0.09)
    }
}
