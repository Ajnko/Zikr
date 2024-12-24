//
//  UserProfileViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 30/10/24.
//

import Foundation

class UserProfileViewModel {
    private let userService = ApiManager()
    var user: HatmGroupUserModel?
    var onUserFetched: ((HatmGroupUserModel) -> Void)?
    
    func fetchUserProfile() {
        userService.fetchUserProfile { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                self?.onUserFetched?(user)
            case .failure(let error):
                print("Error fetching user profile:", error.localizedDescription)
            }
        }
    }
    
}
