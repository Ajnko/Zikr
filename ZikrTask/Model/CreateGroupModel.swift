//
//  GroupModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 09/07/24.
//

import Foundation

struct GroupCreationRequest: Codable {
    let name: String
    let groupType: String
    let isPublic: Bool
    let guruhImg: String
    let kimga: String
    let hatmSoni: Int
}

struct GroupResponse: Codable {
    let idGroup: String
    let name: String
    let groupType: String
    let adminId: String
    let guruhImg: String
    let kimga: String?
    let isPublic: Bool
    let hatmSoni: Int
    let createdAt: String? // Make this optional
    let updatedAt: String? // Make this optional if necessary
}

