//
//  HatimGroupModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 29/09/24.
//

import UIKit

struct HatimGroupCreationRequest: Codable {
    let name: String
    let groupType: String
    let isPublic: Bool
    let guruhImg: String
    let kimga: String
    let hatmSoni: Int
}

struct HatimCreateGroupResponse: Codable {
    let idGroup: String
    let name: String
    let groupType: String
    let adminId: String
    let guruhImg: String
    let kimga: String?
    let isPublic: Bool
    let hatmSoni: Int
    let createdAt: String?
    let updatedAt: String?
}
