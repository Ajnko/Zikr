//
//  ProfileViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 12/09/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private let backgroundImage: UIImageView = {
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
    
    private let profileTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableview.backgroundColor = .clear
        return tableview
    }()
    
    private let profileViewModel = ProfileViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        self.navigationItem.largeTitleDisplayMode = .always
        setupUI()
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        //MARK: - HeaderView for ProfileTableView
        let header = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 120))
        header.backgroundColor = .clear
        header.nameLabel.text = profileViewModel.name
        header.surnameLabel.text = profileViewModel.surname
        header.userIdLabel.text = "Your ID: \(profileViewModel.userId)"
        profileTableView.tableHeaderView = header
    }
    
    private func setupUI() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurView.contentView.addSubview(profileTableView)
        profileTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 80
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModel.getProfileData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.profileDetailsLabel.text = profileViewModel.getProfileData()[indexPath.row]
        cell.backgroundColor = .clear
        return cell
        
    }
    
}

