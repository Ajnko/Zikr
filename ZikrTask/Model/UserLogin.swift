//
//  UserLogin.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

//struct User: Codable {
//    let userId: Int
//    let phone: String
//    let mail: String
//    let name: String
//    let surname: String
//    let groups: String
//    let imageUrl: String
//    let password: String
//    
//    enum CodingKeys: String, CodingKey {
//        case userId = "userId"
//        case phone
//        case mail
//        case name
//        case surname
//        case groups
//        case imageUrl = "image_url"
//        case password
//    }
//    
//    func parsedGroups() -> [String] {
//        guard let data = groups.data(using: .utf8) else { return [] }
//        return (try? JSONDecoder().decode([String].self, from: data)) ?? []
//    }
//}
//
//struct LoginResponse: Codable {
//    let message: String
//    let user: [User]
//}
