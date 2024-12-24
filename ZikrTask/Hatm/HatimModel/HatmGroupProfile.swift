//
//  HatimGroupProfile.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 14/10/24.
//

import Foundation

struct HatmGroupProfile: Codable {
    let name: String
    let kimga: String
    let hatmSoni: Int
}

struct HatmGroupSubscriber: Codable {
    let name: String
    let surname: String
    let phone: String
}

struct HatmGroupDetialsData: Codable {
    let groupProfile: HatmGroupProfile
    let subscribers: [HatmGroupSubscriber]
}

struct HatmGroupDetailResponse: Codable {
    let status: String
    let message: String
    let data: HatmGroupDetialsData
}
