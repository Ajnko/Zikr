//
//  ProfileViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 13/09/24.
//

import Foundation

class ProfileViewModel {
    
    // Data properties for the header view
    var name: String {
        return UserDefaults.standard.string(forKey: "name") ?? ""
    }
    
    var surname: String {
        return UserDefaults.standard.string(forKey: "surname") ?? ""
    }
    
    var userId: String {
        return String(UserDefaults.standard.integer(forKey: "userId"))
    }
    
    var email: String {
        return UserDefaults.standard.string(forKey: "email") ?? ""
    }
    
    var phone: String {
        return UserDefaults.standard.string(forKey: "phone") ?? ""
    }
    
    // This will be used to populate the table view
    func getProfileData() -> [String] {
        return ["Email: \(email)", "Phone: \(phone)"]
    }
}
