//
//  GetHatimGroupViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 02/10/24.
//

import Foundation
import Alamofire

class HatimGetGroupViewModel {
    var groups: [HatimGroupData] = []
    
    func fetchHatimGroups(completion: @escaping (Result<[HatimGroupData], Error>) -> Void) {
        ApiManager.shared.fetchHatimGroups { result in
            switch result {
            case .success(let groups):
                self.groups = groups
                completion(.success(groups))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
