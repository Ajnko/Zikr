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
                print("Group created successfully and saved to User Defaults with ID \(groupResponse.idGroup)")
            case .failure(let error):
                completion("Group creation failed: \(error.localizedDescription)")
            }
        }
    }

    func createZikr(name: String, desc: String, body: String, goal: Int, completion: @escaping(String?) -> Void) {
        guard let groupId = UserDefaults.standard.string(forKey: "groupId") else {
            completion("Group ID not found")
            return
        }

        let zikrRequest = ZikrRequest(
            name: name,
            desc: desc,
            body: body,
            goal: goal
        )

        ApiManager.shared.createZikr(zikrRequest: zikrRequest) { result in
            switch result {
            case .success(let zikrResponse):

                UserDefaults.standard.set(zikrResponse.id, forKey: "zikrId")
                completion("Zikr created successfully with ID: \(zikrResponse.id)")
                print("Zikr created successfully and saved to User Defaults with ID: \(zikrResponse.id)")

            case .failure(let error):
                completion("Zikr creation failed: \(error.localizedDescription)")
                print("Zikr creation failed: \(error.localizedDescription)")
            }
        }
    }

    func createGroupAndZikr(groupName: String, zikrName: String, desc: String, body: String, goal: Int, completion: @escaping(String?) -> Void) {
        createGroup(name: groupName) { groupResult in
            if let message = groupResult, !message.contains("failed") {
                self.createZikr(name: zikrName, desc: desc, body: body, goal: goal) { ZikrRequest in
                    completion("Successfully created group and zikr")
                }
            } else {
                completion(groupResult)
            }
        }
    }
}
