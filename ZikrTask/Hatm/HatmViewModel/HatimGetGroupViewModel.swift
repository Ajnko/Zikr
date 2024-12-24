//
//  GetHatimGroupViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 02/10/24.
//

import Foundation
import Alamofire

class HatimGetGroupViewModel {
    
    var subscriberCounts: [String: Int] = [:]
    let viewModel = HatmGroupDetailsViewModel()
    var publicGroups: [HatmGroupData] = []
    var privateGroups: [HatmGroupData] = []
    
    private func fetchHatmGroups(
        fetchFunction: (@escaping (Result<[HatmGroupData], Error>) -> Void) -> Void,
        updateGroups: @escaping ([HatmGroupData]) -> Void,
        completion: @escaping (Result<[HatmGroupData], Error>) -> Void
    ) {
        fetchFunction { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let groups):
                updateGroups(groups) // Update the corresponding groups (public or private)
                let dispatchGroup = DispatchGroup()
                
                for group in groups {
                    dispatchGroup.enter()
                    self.viewModel.fetchHatmGroupDetails(idGroup: group.groupId) { detailsResult in
                        switch detailsResult {
                        case .success(let details):
                            self.subscriberCounts[group.groupId] = details.subscribers.count
                            print("Subscriber count for group \(group.groupName): \(details.subscribers.count)")
                        case .failure(let error):
                            print("Failed to fetch group details for \(group.groupId): \(error.localizedDescription)")
                        }
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    completion(.success(groups))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPublicHatmGroups(completion: @escaping (Result<[HatmGroupData], Error>) -> Void) {
        fetchHatmGroups(
            fetchFunction: ApiManager.shared.getPublicHatmGroups,
            updateGroups: { [weak self] groups in
                self?.publicGroups = groups
            },
            completion: completion
        )
    }
    
    func fetchPrivateHatmGroups(completion: @escaping (Result<[HatmGroupData], Error>) -> Void) {
        fetchHatmGroups(
            fetchFunction: ApiManager.shared.getPrivateHatmGroups,
            updateGroups: { [weak self] groups in
                self?.privateGroups = groups
            },
            completion: completion
        )
    }
}
