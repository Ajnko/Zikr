//
//  GetGroupViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

import Foundation

class GetGroupViewModel {
    private let apiManager = ApiManager.shared
    var groups: [Group] = []
    var followers: [String] = []
    var reloadTableView: (() -> Void)?

    
    func fetchGroups(completion: @escaping (Result<Void, Error>) -> Void) {
        apiManager.fetchGroups { [weak self] result in
            switch result {
            case .success(let groups):
                self?.groups = groups
                
                if let firstGroup = groups.first {
                    UserDefaults.standard.setValue(firstGroup.groupId, forKey: "groupId")
                    print("Group ID is saved to UserDefaults after user logged in")
                }
                completion(.success(()))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchFollowers() {
        ApiManager.shared.fetchGroups { [weak self] result in
            switch result {
            case .success(let groups):
                // Assuming you want followers from all groups
                self?.followers = groups.flatMap { $0.followers }
                print("Followers: \(self?.followers)")
                DispatchQueue.main.async {
                    self?.reloadTableView
                }
            case .failure(let error):
                print("Failed to fetch followers: \(error)")
            }
        }
    }
    
}
