//
//  RegisterViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 27/09/24.
//

import Foundation

class RegisterViewModel {
    
    var name: String = ""
    var surname: String = ""
    var phone: String = ""
    var mail: String = ""
    var password: String = ""
    
    var onSuccess: ((RegisterResponse) -> Void)?
    var onError: ((String) -> Void)?
    var onLoadingStatusChange: ((Bool) -> Void)?
    
    func registerUser() {
        guard validateInputs() else {return}
        
        let request = RegisterRequest(
            name: name,
            surname: surname,
            phone: phone,
            mail: mail,
            password: password
        )
        
        onLoadingStatusChange?(true)
        
        ApiManager.shared.request(endpoint: "/register", method: .post, parameters: request, headers: ["Content-Type" : "application/json"]) { [weak self] (result: Result<RegisterResponse, Error>) in
            self?.onLoadingStatusChange?(false)
            
            switch result {
            case .success(let response):
                self?.onSuccess?(response)
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func validateInputs() -> Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            onError?("Name is required.")
            return false
        }
        if surname.trimmingCharacters(in: .whitespaces).isEmpty {
            onError?("Surname is required")
            return false
        }
        if phone.trimmingCharacters(in: .whitespaces).isEmpty {
            onError?("Phone number is required")
            return false
        }
        if mail.trimmingCharacters(in: .whitespaces).isEmpty {
            onError?("Email is required")
            return false
        }
        if password.trimmingCharacters(in: .whitespaces).isEmpty {
            onError?("Password is required")
            return false
        }
        return true
    }
}
