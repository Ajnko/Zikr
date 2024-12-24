//
//  AddUserViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 15/11/24.
//

import Foundation

class AddHatmUserViewModel {
    var user: AddHatmUser?
    var errorMessage: String?
    
    func fetchUser(phone: String, completion: @escaping () -> Void) {
        ApiManager.shared.fetchUser(phone: phone) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedUser):
                self.user = fetchedUser
                self.errorMessage = nil
                
                UserDefaults.standard.set(fetchedUser.userId, forKey: "addedUserId")
                print("\(fetchedUser.userId)")
                completion()
            case .failure(let error):
                self.user = nil
                self.errorMessage = "Failed to fetch user: \(error.localizedDescription)"
                completion()
            }
        }
    }
    
    func numberOfUsers() -> Int {
        return user == nil ? 0 : 1
    }
    
}

