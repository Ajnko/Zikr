//
//  ZikrCountsModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 23/10/24.
//

import Foundation

struct ZikrCountRequest: Codable {
    let groupId: String
    let zikrId: String
    let count: Int
}

struct ZikrCountResponse: Codable {
    let totalCount: Int
    let goalReached: Bool
}


//struct ZikrCountRequest: Codable {
//    let groupId: String
//    let zikrId: String
//    let count: Int
//}
//
//struct ZikrCountResponse: Codable {
//    let totalCount: Int
//    let goalReached: Bool
//}
