//
//  GetGroupModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

struct Group: Codable {
    let idGroup: String
    let name: String
    let groupType: String
    let adminId: String
    let guruhImg: String
    let kimga: String
    let isPublic: Bool
    let hatmSoni: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case idGroup
        case name
        case groupType
        case adminId
        case guruhImg
        case kimga
        case isPublic
        case hatmSoni
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


