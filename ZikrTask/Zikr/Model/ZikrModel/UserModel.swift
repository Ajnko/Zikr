//
//  UserModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 08/07/24.
//

import Foundation

struct UserResponse: Codable {
    let message: String
    let user: User
    let token: String
}

struct User: Codable {
    let userId: String
    let phone: String
    let email: String
    let name: String
    let surname: String
    let imageUrl: String?
    let createdAt: String
    let updatedAt: String
    let role: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case phone = "phone"
        case email = "email"
        case name = "name"
        case surname = "surname"
        case imageUrl = "image_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case role = "role"
    }
}
