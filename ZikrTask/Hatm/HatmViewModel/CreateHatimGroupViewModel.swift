//
//  HatimGroupViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 29/09/24.
//

import Foundation
import Alamofire

class CreateHatimGroupViewModel {
    func createGroup(name: String, kimga: String, hatmCount: Int, completion: @escaping (Result<HatimCreateGroupResponse, Error>) -> Void) {
        let groupRequest = HatimGroupCreationRequest(name: name, groupType: "QURAN", isPublic: true, guruhImg: "image_url", kimga: kimga, hatmSoni: hatmCount)
        
        ApiManager.shared.createHatimGroup(groupRequest: groupRequest) { result in
            completion(result)
        }
    }
    
    func createPrivateGroup(name: String, kimga: String, hatmCount: Int, completion: @escaping (Result<HatimCreateGroupResponse, Error>) -> Void) {
        let groupRequest = HatimGroupCreationRequest(name: name, groupType: "QURAN", isPublic: false, guruhImg: "image_url", kimga: kimga, hatmSoni: hatmCount)
        
        ApiManager.shared.createHatimGroup(groupRequest: groupRequest) { result in
            completion(result)
        }
    }
}

