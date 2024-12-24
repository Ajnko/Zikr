//
//  PatchBookedPora.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 20/12/24.
//

import Foundation

struct PatchBookedPoralarRequest: Encodable {
    let isBooked: Bool
    let isDone: Bool
    let poraId: String
}

struct PatchBookedPoralarResponse: Decodable {
    let id: String
    let poraId: String
    let idGroup: String
    let userId: String
    let isBooked: Bool
    let isDone: Bool
    let created_at: String
    let updated_at: String
    
}
