//
//  SendNotificationModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 21/11/24.
//

struct HatmNotificationResponse: Decodable {
    let id: String
    let senderId: String
    let receiverId: String
    let groupId: String
    let isInvite: Bool
    let isRead: Bool
    let time: String
    let created_at: String
    let updated_at: String
    let groupName: String
}

struct ErrorNotificationResponse: Decodable {
    let message: String?
    let error: String?
    let statusCode: Int?
}

