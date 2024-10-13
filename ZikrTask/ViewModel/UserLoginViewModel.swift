//
//  UserLoginViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

class LoginViewModel {
    
    func loginUser(email: String, phone: String, password: String, completion: @escaping(String?) -> Void) {
        ApiManager.shared.loginUser(email: email, phone: phone, password: password) { result in
            switch result {
            case .success(let loginResponse):
                UserDefaults.standard.set(loginResponse.token, forKey: "token")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                
                completion("Login successful")
                print("User logged in successfully")
            case .failure(let error):
                completion("Login failed: \(error.localizedDescription)")
            }
        }
    }
}


