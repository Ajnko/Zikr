//
//  GetUserDetailViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 07/12/24.
//

import Alamofire
import Foundation

class GetUserDetailViewModel {
    var userDetails: [String: HatmGroupUserDetail] = [:]
    var loggedInUserId: String?
    var didFetchUserDetails: (() -> Void)?
    
    func fetchLoggedInUserDetails() {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let url = "https://dzikr.uz/api/v1/users/me"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: HatmGroupUserResponse.self) { [weak self] response in
            switch response.result {
            case .success(let userResponse):
                self?.loggedInUserId = userResponse.data.userId
                self?.didFetchUserDetails?()
            case .failure(let error):
                print("Failed to fetch logged-in user details: \(error.localizedDescription)")
            }
        }
    }
}

struct HatmGroupUserResponse: Codable {
    let status: Bool
    let message: String
    let data: HatmGroupUserDetail
}

struct HatmGroupUserDetail: Codable {
    let userId: String
    let name: String
    let surname: String
}
