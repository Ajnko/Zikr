//
//  NotificationViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 22/11/24.
//

import Foundation

class HatmNotificationViewModel {
    
    var notifications: [GetHatmNotificationModel] = []
    var onDataUpdated: (() -> Void)?
    var groupNotificationIds: [String] = []
    
    init() {
        
    }
    
    
    //MARK: - Get Notification
    
    func getNotification() {
        ApiManager.shared.getNotification { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let notificationResponse):
                self.notifications = notificationResponse
                self.saveNotificationIdsToUserDefaults()
                self.onDataUpdated?()
                print("Successfully fetched notifications")
            case .failure(let error):
                print("Error fetching notification: \(error)")
            }
        }
    }
    
    func getNotificationCount() -> Int {
        return notifications.count
    }
    
    func getNotification(at index: Int) -> GetHatmNotificationModel {
        return notifications[index]
    }
    
    private func saveNotificationIdsToUserDefaults() {
        let notificationIds = notifications.map { $0.id }
        let groupNotificationIds = notifications.map { $0.groupId }
        UserDefaults.standard.set(notificationIds, forKey: "savedNotificationIds")
        UserDefaults.standard.set(notificationIds, forKey: "groupNotificationIds")
        
    }
    
    //MARK: - Subscribe to the group
    
    private func loadGroupNotificationIds() {
        if let savedGroupIds = UserDefaults.standard.array(forKey: "groupNotificationIds") as? [String] {
            print(savedGroupIds)
            self.groupNotificationIds = savedGroupIds
        } else {
            print("No groupNotificationIds found in UserDefaults")
        }
    }
    
    func subscribeToGroup(at index: Int) {
        guard index < groupNotificationIds.count else {
            print("Invalid index for GroupNotificationIds")
            return
        }
        
        let groupId = groupNotificationIds[index]
        //        ApiManager.shared.subscribeToGroup(groupId: groupId) { result in
        //            switch result {
        //            case .success():
        //                print("Successfully subscribed to group with ID: \(groupId)")
        //            case .failure(let error):
        //                print("Failed to subscribe to group. Error: \(groupId)")
        //            }
        //        }
    }
    
    
    //MARK: - Send Notification
    
    func sendNotification(receiverId: String, groupId: String, completion: @escaping (Result<HatmNotificationResponse, Error>) -> Void) {
        ApiManager.shared.sendNotification(receiverId: receiverId, groupId: groupId) { result in
            completion(result)
        }
    }
    
    //MARK: - Patch Notification
    func patchNotification(at index: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard index < notifications.count else {
            completion(.failure(NSError(domain: "InvalidIndex", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid notification index"])))
            return
        }
        
        ApiManager.shared.patchNotification(at: index) { [weak self] result in
            switch result {
            case .success:
                self?.notifications[index].isRead = true // Update the local model
                self?.onDataUpdated?() // Notify the view to refresh UI
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Delete Notification
    func deleteNotification(at index: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard index < notifications.count else {
            completion(.failure(NSError(domain: "InvalidIndex", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid notification index"])))
            return
        }
        
        ApiManager.shared.deleteNotification(at: index) { [weak self] result in
            switch result {
            case .success:
                self?.notifications.remove(at: index) // Remove the notification locally
                self?.onDataUpdated?() // Notify the view to refresh UI
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
