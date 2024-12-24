//
//  GetGroupViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

class GetGroupAndZikrViewModel {
    
    var groups: [Group] = []
    var zikrsByGroupId: [String: [Zikr]] = [:]
    

    func fetchGroupsAndZikrs(completion: @escaping (String?) -> Void) {

        groups.removeAll()
        zikrsByGroupId.removeAll()
        

        ApiManager.shared.getGroups { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedGroups):
                self.groups = fetchedGroups
                
                if fetchedGroups.isEmpty {
                    completion("No groups found.")
                    return
                }
                

                let dispatchGroup = DispatchGroup()
                var fetchErrors: [String] = []
                
                for group in fetchedGroups {
                    dispatchGroup.enter()
                    ApiManager.shared.getZikrs(forGroupId: group.groupId) { zikrResult in
                        switch zikrResult {
                        case .success(let fetchedZikrs):
                            self.zikrsByGroupId[group.groupId] = fetchedZikrs
                        case .failure(let error):
                            let errorMessage = "Failed to fetch zikrs for group \(group.groupName): \(error.localizedDescription)"
                            print(errorMessage)
                            fetchErrors.append(errorMessage)
                        }
                        dispatchGroup.leave()
                    }
                }
                

                dispatchGroup.notify(queue: .main) {
                    if !fetchErrors.isEmpty {
                        completion(fetchErrors.joined(separator: "\n"))
                    } else {
                        completion(nil)
                    }
                }
                
            case .failure(let error):
                print("Failed to fetch groups: \(error.localizedDescription)")
                completion("Failed to fetch groups: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfGroups() -> Int {
        return groups.count
    }
    
    func group(at index: Int) -> Group {
        return groups[index]
    }
    
    func zikrsForGroup(at index: Int) -> [Zikr] {
        let groupId = groups[index].groupId
        return zikrsByGroupId[groupId] ?? []
    }
    
    func zikrProgressForGroup(at index: Int) -> [ZikrProgress] {
        return groups[index].zikrProgress
    }
    
    func numberOfZikrItems(inGroupAt index: Int) -> Int {
        return groups[index].zikrProgress.count
    }
}
