//
//  GetGroupViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

import Foundation

class GroupViewModel {
    var groups: [Group] = []
    
    func fetchGroups(completion: @escaping (String?) -> Void) {
        ApiManager.shared.getGroups { [weak self] result in
            switch result {
            case .success(let fetchedGroups):
                self?.groups = fetchedGroups
                completion(nil)  // No error, success
            case .failure(let error):
                print("Failed to fetch groups: \(error.localizedDescription)")
                completion("Failed to fetch groups: \(error.localizedDescription)")
            }
        }
    }
}



