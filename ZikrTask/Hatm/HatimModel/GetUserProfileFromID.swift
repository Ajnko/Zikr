//
//  GetUserProfileFromID.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 02/11/24.
//

import Foundation

struct UserDetailResponse: Decodable {
    let status: Bool
    let message: String
    let data: UserDetail
}

struct UserDetail: Decodable {
    let userId: String
    let phone: String
    let email: String
    let name: String
    let surname: String
    let imageUrl: String?
    let password: String
    let createdAt: String
    let updatedAt: String
    let role: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case phone
        case email
        case name
        case surname
        case imageUrl = "image_url"
        case password
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case role
    }
}

