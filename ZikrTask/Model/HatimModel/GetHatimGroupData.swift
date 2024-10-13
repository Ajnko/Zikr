//
//  GetHatimGroupModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 02/10/24.
//

import Foundation

struct HatimGroupData: Decodable {
    let idGroup: String
    let name: String
    let groupType: String
    let adminId: String
    let guruhImg: String
    let kimga: String
    let isPublic: Bool
    let hatmSoni: Int
    let createdAt: String // You can convert this to a Date if needed
    let updatedAt: String // You can convert this to a Date if needed
    
    // Coding keys to match the JSON keys if they differ from the property names
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
