//
//  GetNotificationModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 21/11/24.
//

struct GetNotificationModel: Decodable {
    let id: String
    let senderId: String
    let receiverId: String
    let groupId: String
    let isInvite: Bool
    var isRead: Bool
    let time: String
    let created_at: String
    let updated_at: String
    let group:  GetGroupName?
    
    enum CodingKeys: String, CodingKey {
        case id
        case senderId = "senderId"
        case receiverId = "receiverId"
        case groupId = "groupId"
        case isInvite = "isInvite"
        case isRead = "isRead"
        case time
        case created_at = "created_at"
        case updated_at = "updated_at"
        case group
    }
}

struct GetGroupName: Decodable {
    let name: String
}
