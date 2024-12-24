//
//  HatmNotificationViewController.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 24/12/24.
//

import UIKit
import SnapKit

class HatmNotificationViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let blurView: UIVisualEffectView = {
        let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    private let blurEffect = UIBlurEffect(style: .light)
    
    let notificationTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(HatmNotificationTableViewCell.self, forCellReuseIdentifier: HatmNotificationTableViewCell.identifier)
        return table
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .black
        indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.alpha = 0
        
        return view
    }()
    
    private let notificationViewModel = HatmNotificationViewModel()
    private var groupNotificationIds: [String] = []
    let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bildirishnomalar"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .darkMode
        
        setupUI()
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        
        bindViewModel()
        notificationViewModel.getNotification()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        notificationTableView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl.endRefreshing()
            self.notificationViewModel.getNotification()
        }
    }
    
    func setupUI() {
        
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        blurView.contentView.addSubview(notificationTableView)
        notificationTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.bringSubviewToFront(notificationTableView)
        
    }
    
    func bindViewModel() {
        notificationViewModel.onDataUpdated = {[weak self] in
            self?.showActivityIndicator()
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                self?.notificationTableView.reloadData()
                self?.groupNotificationIds = self!.notificationViewModel.groupNotificationIds
                
            }
        }
    }
    
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
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension HatmNotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationViewModel.getNotificationCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HatmNotificationTableViewCell.identifier, for: indexPath) as! HatmNotificationTableViewCell
        cell.backgroundColor = .clear
        
        let data = notificationViewModel.getNotification(at: indexPath.row)
        cell.configureCell(with: data)
        
        _ = notificationViewModel.notifications[indexPath.row]
        cell.onSubscribeButtonTapped = { [weak self] in
            guard let self = self else {return}
            self.notificationViewModel.subscribeToGroup(at: indexPath.row)
        }
        return cell
    }
    
    //Swipe to Mark Read
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let markAsReadAction = UIContextualAction(style: .normal, title: "Mark as Read") { [weak self] _, _, completionHandler in
            self?.notificationViewModel.patchNotification(at: indexPath.row) { result in
                switch result {
                case .success:
                    print("Notification marked as read.")
                case .failure(let error):
                    print("Error marking notification as read: \(error.localizedDescription)")
                }
                completionHandler(true)
            }
        }
        
        markAsReadAction.backgroundColor = .systemBlue
        markAsReadAction.image = UIImage(systemName: "envelope.open.fill")
        markAsReadAction.title = "Read"
        return UISwipeActionsConfiguration(actions: [markAsReadAction])
    }
    
    //Swipe to Delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            self?.notificationViewModel.deleteNotification(at: indexPath.row) { result in
                switch result {
                case .success:
                    print("Notification deleted successfully.")
                case .failure(let error):
                    print("Error deleting notification: \(error.localizedDescription)")
                }
                completionHandler(true)
            }
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
