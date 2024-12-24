//
//  GetUserDetailFromID.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 02/11/24.
//

import Foundation
import Alamofire

class GetUserDetailFromID {
    
    var userDetails: [String: UserDetail] = [:]
    var didFetchUserDetails: (() -> Void)?
    
    func fetchUserDetails(userId: String) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Token not found in UserDefaults")
            return
        }
        
        let urlString = "https://dzikr.uz/api/v1/users/\(userId)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(urlString, method: .get, headers: headers).validate().responseDecodable(of: UserDetailResponse.self) { [weak self] response in
            switch response.result {
            case .success(let userDetailResponse):
                if userDetailResponse.status {
                    self?.userDetails[userId] = userDetailResponse.data
                    self?.didFetchUserDetails?() // Notify the view controller about user details
                } else {
                    print("User not found: \(userDetailResponse.message)")
                }
            case .failure(let error):
                print("Error fetching user details: \(error.localizedDescription)")
            }
        }
    }
}
