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
    
    func fetchGroups(completion: @escaping (Result<Void, Error>) -> Void) {
        apiManager.fetchGroups { [weak self] result in
            switch result {
            case .success(let groups):
                self?.groups = groups
                completion(.success(()))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
