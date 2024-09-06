//
//  GetGroupViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

class GetGroupViewModel {
    var groups: [Group] = []
    
    func createGroup(name: String, purpose: String, comment: String, imageUrl: String, completion: @escaping (Bool) -> Void) {
        // Your existing createGroup method
    }
    
    func fetchGroups(completion: @escaping (Bool) -> Void) {
        guard let ownerId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            print("ownerId not found in UserDefaults")
            completion(false)
            return
        }
        
        ApiManager.shared.fetchGroups(ownerId: String(ownerId)) { result in
            switch result {
            case .success(let groups):
                self.groups = groups  // Assign the array of Group objects
                completion(true)
            case .failure(let error):
                print("Failed to fetch groups: \(error)")
                completion(false)
            }
        }
    }
}

