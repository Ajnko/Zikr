//
//  UserLoginViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

class UserLoginViewModel {
    private let apiManager = ApiManager.shared
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        apiManager.loginUser(email: email, password: password) { result in
            completion(result)
        }
    }
}
