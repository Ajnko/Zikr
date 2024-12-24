//
//  GetBookedPora.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 02/11/24.
//

struct GetBookedPora: Codable {
    let id: String
    let poraId: String
    let idGroup: String
    let userId: String
    let isBooked: Bool
    let isDone: Bool
    let createdAt: String
    let updatedAt: String
    let pora: GetPora
    
    enum CodingKeys: String, CodingKey {
        case id
        case poraId
        case idGroup
        case userId
        case isBooked
        case isDone
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pora
    }
}

struct GetPora: Codable {
    let id: String
    let name: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
