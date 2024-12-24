//
//  GetHatimGroupModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 02/10/24.
//

import Foundation

struct HatmGroupData: Decodable {
    let groupId: String
    let groupName: String
    let groupType: String
    let adminId: String
    let guruhImg: String
    let kimga: String
    let isPublic: Bool
    let hatmSoni: Int
    let zikrProgress: [HatmProgress]
}

struct HatmProgress: Decodable {
    let zikrName: String
    let zikrCount: Int
    let goal: Int
    let progress: Int
}
