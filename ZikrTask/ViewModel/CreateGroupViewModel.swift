//
//  GroupViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 18/07/24.
//

import Foundation

class CreateGroupViewModel {
    func createGroup(name: String, completion: @escaping (String?) -> Void) {
        let groupRequest = GroupCreationRequest(
            name: name,
            groupType: "ZIKR",
            isPublic: true,
            guruhImg: "image_url",
            kimga: "",
            hatmSoni: 1
        )
        ApiManager.shared.createGroup(groupRequest: groupRequest) { result in
            switch result {
            case .success(let groupResponse):
                UserDefaults.standard.set(groupResponse.idGroup, forKey: "groupId")
                completion("Group created successfully with ID: \(groupResponse.idGroup)")
                print("Group created successfully with ID: \(groupResponse.idGroup)")
            case .failure(let error):
                completion("Group creation failed: \(error.localizedDescription)")
            }
        }
    }
}
