//
//  UserModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 08/07/24.
//

import Foundation

struct UserRegisterRequest: Codable {
    let name: String
    let surname: String
    let phone: String
    let mail: String
    let image_url: String
    let password: String
}

struct UserRegisterResponse: Codable {
    let message: String
    let data: UserData
}

struct UserData: Codable {
    let userId: Int
    let token: String
    let user: UserDetails
}

struct UserDetails: Codable {
    let name: String
    let surname: String
    let phone: String
    let mail: String
    let image_url: String
}

//struct UserBodyPart: Codable {
//    let phone:Int
//    let mail:String
//    let name:String
//    let surname:String
//    let image_url:String
//    let password:String
//}
//
//struct UserModel: Codable {
//    let status : String
//    let message: String
//    let data: UserResult
//}
//
//struct UserResult: Codable {
//    let userId : Int
//}
