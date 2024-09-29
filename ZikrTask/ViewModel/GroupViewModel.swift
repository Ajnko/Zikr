//
//  GroupViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 18/07/24.
//

import Foundation

//class GroupViewModel {
//    func createGroup(name: String, purpose: String, comment: String, imageUrl: String, completion: @escaping (Bool) -> Void) {
//
//        guard let ownerId = UserDefaults.standard.value(forKey: "userId") as? Int else {
//            print("ownerId not found in UserDefaults")
//            completion(false)
//            return
//        }
//        
//        let groupRequest = GroupRequest(
//            ownerId: String(ownerId),
//            name: name,
//            purpose: purpose,
//            comment: comment,
//            imageUrl: imageUrl,
//            isPublic: true
//        )
//        
//
//        ApiManager.shared.addGroup(groupRequest: groupRequest) { result in
//            switch result {
//            case .success(let response):
//                print("Group created successfully: \(response)")
//                UserDefaults.standard.setValue(response.data.groupId, forKey: "groupId")
//                print("Group ID is successfully saved to UserDefaults: \(response.data.groupId)")
//                completion(true)
//            case .failure(let error):
//                print("Failed to create group: \(error)")
//                completion(false)
//            }
//        }
//    }
//}
