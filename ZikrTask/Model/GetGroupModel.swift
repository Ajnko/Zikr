//
//  GetGroupModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

struct GetGroupResponse: Codable {
    let status: String
    let message: String
    let data: [Group]
}

struct Group: Codable {
    let groupId: Int
    let name: String
    let purpose: String
    let followers: [String]
    let totalCount: String
    let imageUrl: String
    let isPublic: Int

    enum CodingKeys: String, CodingKey {
        case groupId
        case name
        case purpose
        case followers
        case totalCount = "total_count"
        case imageUrl = "image_url"
        case isPublic
    }
}
