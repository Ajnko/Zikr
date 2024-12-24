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
                // Save user data to UserDefaults
                self.saveUserDataToUserDefaults(
                    userId: userResponse.user.userId,
                    token: userResponse.token,
                    name: name,
                    surname: surname,
                    email: email,
                    phone: phone
                )
                
                print("User details and token successfully saved")
                
                // Call completion with success message
                completion(userResponse.message)
                
            case .failure(let error):
                // Call completion with error message
                completion("Registration failed: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveUserDataToUserDefaults(userId: String, token: String, name: String, surname: String, email: String, phone: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(userId, forKey: "userId")
        userDefaults.set(token, forKey: "token")
        userDefaults.set(name, forKey: "userName")
        userDefaults.set(surname, forKey: "userSurname")
        userDefaults.set(email, forKey: "userEmail")
        userDefaults.set(phone, forKey: "userPhone")
        userDefaults.set(true, forKey: "isLoggedIn")
    }
}

