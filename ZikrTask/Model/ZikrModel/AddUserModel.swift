//
//  AddUserModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 15/11/24.
//

import Foundation

struct AddUserResponse: Decodable {
    let status: String
    let message: String
    let data: AddUser?
}

struct AddUser: Decodable {
    let userId: String
    let phone: String
    let email: String
    let name: String
    let surname: String
    let image_url: String?
    let password: String
    let created_at: String
    let updated_at: String
    let role: String

    private enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case phone = "phone"
        case email = "email"
        case name = "name"
        case surname = "surname"
        case image_url = "image_url"
        case password = "password"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case role = "role"
    }
}

struct ErrorResponse: Decodable {
    let message: String?
    let error: String?
    let statusCode: Int?
}
