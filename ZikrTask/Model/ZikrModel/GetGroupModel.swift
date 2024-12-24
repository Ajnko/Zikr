//
//  GetGroupModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 04/09/24.
//

import Foundation

struct Group: Decodable {
    let groupId: String
    let groupName: String
    let groupType: String
    var zikrProgress: [ZikrProgress]
    var totalZikrCount: Int = 0

    enum CodingKeys: String, CodingKey {
        case groupId
        case groupName
        case groupType
        case zikrProgress
    }
}

struct ZikrProgress: Decodable {
    let zikrName: String
    var zikrCount: Int
    let goal: Int
    let progress: Double

    enum CodingKeys: String, CodingKey {
        case zikrName
        case zikrCount
        case goal
        case progress
    }
}
