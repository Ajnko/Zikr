//
//  UserLoginViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

class UserLoginViewModel {
    private let apiManager = ApiManager.shared
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        ApiManager.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
                self.saveUserToUserDefaults(user)
                print("Successfully saved user details and userId to UserDefaults: \(user)")
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func saveUserToUserDefaults(_ user: User) {
        UserDefaults.standard.set(user.name, forKey: "name")
        UserDefaults.standard.set(user.surname, forKey: "surname")
        UserDefaults.standard.set(user.mail, forKey: "email")
        UserDefaults.standard.set(user.phone, forKey: "phone")
        UserDefaults.standard.set(user.userId, forKey: "userId")
        UserDefaults.standard.set(user.imageUrl, forKey: "image_url")
        UserDefaults.standard.synchronize()
    }
}
