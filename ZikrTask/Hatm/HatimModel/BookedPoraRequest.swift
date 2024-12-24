//
//  BookedPoraRequest.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 01/11/24.
//

struct BookedPoraRequest: Codable {
    let idGroup: String
    let poraId: String
    let isBooked: Bool
    let isDone: Bool
}
