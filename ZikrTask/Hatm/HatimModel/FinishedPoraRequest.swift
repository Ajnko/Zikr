//
//  FinishedPoraRequest.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 22/11/24.
//

import Foundation

struct FinishedPoraRequest: Codable {
    let idGroup: String
    let juzCount: Int
}

struct FinishedPoraResponse: Codable {
    let id: String
    let juzCount: Int
    let idGroup: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case juzCount
        case idGroup
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
