//
//  PoralarModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 29/10/24.
//

import Foundation

struct PoralarModel: Codable {
    let id: String
    let name: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
