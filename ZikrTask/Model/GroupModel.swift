//
//  GroupModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 09/07/24.
//

import Foundation

struct GroupRequest: Codable {
    let ownerId: String
    let name: String
    let purpose: String
    let comment: String
    let imageUrl: String
    let isPublic: Bool
    
    enum CodingKeys: String, CodingKey {
        case ownerId
        case name
        case purpose
        case comment
        case imageUrl = "image_url"
        case isPublic
    }
}

struct GroupResponse: Codable {
    let status: String
    let message: String
    let data: GroupData
}

struct GroupData: Codable { 
    let groupId: Int
    let ownerId: String
    let name: String
    let followers: [String]
    let purpose: String
    let totalCount: String
    let isPublic: Int
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case groupId = "groupId"
        case ownerId = "ownerId"
        case name = "name"
        case followers = "followers"
        case purpose = "purpose"
        case totalCount = "total_count"
        case isPublic = "isPublic"
        case imageUrl = "image_url"
    }
}
