//
//  LoginResponse.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 02/10/24.
//


struct LoginResponse: Codable {
    let message: String
    let token: String
    let user: User
}

struct User: Codable {
    let id: Int
    let name: String
    let surname: String
    let mail: String
    let phone: String
    let image_url: String
}
