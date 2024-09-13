//
//  URL.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

struct APIConstants {
    // Base URL
    static let baseURL = "http://dzikr.uz"

    // Endpoints
    static let login = "/zikrs/login"
    static let addUser = "/zikrs/add-user"
    static let addGroup = "/zikrs/add-group"
    static let getGroups = "/zikrs/group?ownerId="
    
    // Full URLs
    static func loginURL(mail: String, password: String) -> String {
        return "\(baseURL)\(login)?mail=\(mail)&password=\(password)"
    }
    
    static func addUserURL() -> String {
        return baseURL + addUser  // Update URL for creating user
    }
    
    static func addGroupURL() -> String {
        return baseURL + addGroup
    }
    
    static func getGroupsURL(ownerId: String) -> String {
        return baseURL + getGroups + ownerId
    }
}

