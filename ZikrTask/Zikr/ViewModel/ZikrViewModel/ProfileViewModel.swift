    //
//  ProfileViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 13/09/24.
//

import Foundation

class ProfileViewModel {
    
    var name: String {
        return UserDefaults.standard.string(forKey: "userName") ?? ""
    }
    
    var surname: String {
        return UserDefaults.standard.string(forKey: "userSurname") ?? ""
    }
    
    var userId: String {
        return UserDefaults.standard.string(forKey: "userId") ?? ""
    }
    
    var email: String {
        return UserDefaults.standard.string(forKey: "userEmail") ?? ""
    }
    
    var phone: String {
        return UserDefaults.standard.string(forKey: "userPhone") ?? ""
    }
    
    func getProfileData() -> [String] {
        return ["Email: \(email)", "Phone: \(phone)"]
    }
}
