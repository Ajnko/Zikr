//
//  MembersListViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 09/07/24.
//

import UIKit
import SnapKit

class MembersListViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let membersTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(MembersListTableViewCell.self, forCellReuseIdentifier: MembersListTableViewCell.identifier)
        tableview.backgroundColor = .clear
        tableview.rowHeight = 60
        return tableview
    }()
    
//    let getFollowersViewModel = GetGroupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Members List"
        
        membersTableView.delegate = self
        membersTableView.dataSource = self
        
        setupUI()
        fetchFollowers()
    }
    
    func setupUI() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(membersTableView)
        membersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func fetchFollowers() {
//        getFollowersViewModel.fetchFollowers()
    }
    

}

extension MembersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0/*getFollowersViewModel.followers.count*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MembersListTableViewCell.identifier, for: indexPath) as! MembersListTableViewCell
        cell.backgroundColor = .clear
//        cell.membersNameLabel.text = getFollowersViewModel.followers[indexPath.row]
        return cell
    }
}
