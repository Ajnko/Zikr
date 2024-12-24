//
//  PoralarViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 29/10/24.
//

import Foundation

class PoralarViewModel {
    var groups: [PoralarModel] = []
    
    var onGroupsFetched: (() -> Void)?
    
    func fetchGroups() {
        ApiManager.shared.fetchPoralar { [weak self] result in
            switch result {
            case .success(let groups):
                self?.groups = groups
                self?.onGroupsFetched?()
            case .failure(let error):
                print("Failed to fetch groups:", error.localizedDescription)
            }
        }
    }
    
    func numberOfGroups() -> Int {
        return groups.count
    }
    
    func group(at index: Int) -> PoralarModel {
        return groups[index]
    }
}
