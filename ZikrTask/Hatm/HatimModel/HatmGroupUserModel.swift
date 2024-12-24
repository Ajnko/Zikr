//
//  HatmGroupUserModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 30/10/24.
//

import Foundation

struct HatmGroupUserModel: Codable {
    let name: String
    let surname: String
}

struct UserProfileResponse: Codable {
    let status: Bool
    let message: String
    let data: HatmGroupUserModel
}
