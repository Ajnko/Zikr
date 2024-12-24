//
//  CreateZikr.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 12/10/24.
//

import Foundation

struct ZikrRequest: Codable {
    let name: String
    let desc: String
    let body: String
    let goal: Int
}

struct ZikrResponse: Codable {
    let id: String
    let name: String
    let desc: String
    let body: String
    let soundUrl: String
    let goal: Int
    let groupId: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc
        case body
        case soundUrl = "sound_url"
        case goal
        case groupId
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


