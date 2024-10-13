//
//  UserViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 08/07/24.
//

import Foundation

class UserRegistrationViewModel {
    
    func registerUser(name: String, surname: String, email: String, password: String, phone: String, completion: @escaping (String?) -> Void) {
        ApiManager.shared.registerUser(name: name, surname: surname, email: email, password: password, phone: phone) { result in
            switch result {
            case .success(let userResponse):
                // Save userId and token to UserDefaults
                UserDefaults.standard.set(userResponse.user.userId, forKey: "userId")
                UserDefaults.standard.set(userResponse.token, forKey: "token")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                print("Token is successfully saved \(userResponse.token)")
                
                // Call completion with success message
                completion(userResponse.message)
                
            case .failure(let error):
                // Call completion with error message
                completion("Registration failed: \(error.localizedDescription)")
            }
        }
    }
}
