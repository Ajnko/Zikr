//
//  HatimGroupMembersListViewController.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 03/10/24.
//

import UIKit
import SnapKit

class HatimGroupMembersListViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let membersTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(HatimGroupMemberListTableViewCell.self, forCellReuseIdentifier: HatimGroupMemberListTableViewCell.identifier)
        tableview.backgroundColor = .clear
        tableview.rowHeight = 60
        return tableview
    }()
    
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
        
        
    }
}

extension HatimGroupMembersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HatimGroupMemberListTableViewCell.identifier, for: indexPath) as! HatimGroupMemberListTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
}
