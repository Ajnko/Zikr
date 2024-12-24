//
//  ApiManager.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 24/08/24.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    
    //    private init() {}
    
    //MARK: - Create User
    
    func registerUser(name: String, surname: String, email: String, password: String, phone: String, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/auth/register"
        
        print("Register URL: \(url)")
        
        let parameters: [String: Any] = [
            "name": name,
            "surname": surname,
            "email": email,
            "password": password,
            "phone": phone
        ]
        

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                // Print raw response data for debugging
                if let data = data {
                    let rawData = String(data: data, encoding: .utf8) ?? "No Data"
                    print("Raw Response Data: \(rawData)")
                }
                
                // Attempt to decode to UserResponse
                do {
                    let decodedResponse = try JSONDecoder().decode(UserResponse.self, from: data!)
                    completion(.success(decodedResponse))
                } catch {
                    print("Decoding Error: \(error)")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("Request Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Login User
    
    func loginUser(email: String, phone: String, password: String, completion: @escaping(Result<LoginResponse, Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/auth/login"
        
        let parameters: [String: Any] = [
            "email": email,
            "phone": phone,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of:LoginResponse.self) { resposne in
            switch resposne.result {
            case .success(let loginResponse):
                completion(.success(loginResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Create group
    
    func createGroup(groupRequest: GroupCreationRequest, completion: @escaping (Result<GroupResponse, Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "ApiManager", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated"])))
            return
        }
        
        let url = "\(APIConstants.baseURL)/groups"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: groupRequest, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: GroupResponse.self) { response in
            switch response.result {
            case .success(let groupResponse):
                completion(.success(groupResponse))
            case .failure(let error):
                // Handle response errors separately for better debugging
                if let data = response.data {
                    print("Raw Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
                }
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Create Zikr
    
        func createZikr(zikrRequest: ZikrRequest, completion: @escaping (Result<ZikrResponse, Error>) -> Void) {
            guard let token = UserDefaults.standard.string(forKey: "token"),
                  let groupId = UserDefaults.standard.string(forKey: "groupId") else {
                completion(.failure(NSError(domain: "Token or Group ID not found", code: 401, userInfo: nil)))
                return
            }
    
            let url = "\(APIConstants.baseURL)/zikr"
    
            var parameters: [String: Any] = [
                "name": zikrRequest.name,
                "desc": zikrRequest.desc,
                "body": zikrRequest.body,
                "goal": zikrRequest.goal,
                "sound_url": "https://example.com/sound.mp3", // Use your sound URL as needed
                "groupId": groupId
            ]
    

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(token)"]).responseDecodable(of: ZikrResponse.self) { response in
                switch response.result {
                case .success(let zikrResponse):
                    completion(.success(zikrResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    //MARK: - Get Zikr Group
    
    func getGroups(completion: @escaping (Result<[Group], Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/groups/public/mine?groupType=ZIKR"
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                do {
                    // Try to decode the response data into an array of Group
                    let groups = try JSONDecoder().decode([Group].self, from: response.data!)
                    completion(.success(groups))
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    print("Response data: \(String(data: response.data!, encoding: .utf8) ?? "")") // Log the raw JSON response
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Subscribe to the group
    
    func subscribeToGroup(groupId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/group/subscribe"
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "groupId": groupId
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    //MARK: - Get Zikr
    
    func getZikrs(forGroupId groupId: String, completion: @escaping (Result<[Zikr], Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/zikr/\(groupId)/zikrs" // Use the provided URL format
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [Zikr].self) { response in
            switch response.result {
            case .success(let zikrs):
                completion(.success(zikrs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Post Zikr Count
    
    func postZikrCount(request: ZikrCountRequest, completion: @escaping (Result<ZikrCountResponse, Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/zikr-counts/add-zikr-count"


        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]


        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let data = response.data {
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
            }

            switch response.result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data in response"])))
                    return
                }
                
                do {
                    let zikrCountResponse = try JSONDecoder().decode(ZikrCountResponse.self, from: data)
                    completion(.success(zikrCountResponse))
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Request error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Find User By Phone number
    
    func fetchUser(phone: String, completion: @escaping (Result<AddUser, Error>) -> Void) {
        let urlString = "\(APIConstants.baseURL)/users/find?phone=%2B\(phone)"

        // Retrieve token from UserDefaults
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "NoToken", code: 401, userInfo: [NSLocalizedDescriptionKey: "User token is missing"])))
            return
        }

        // Set headers with Authorization Bearer token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]

        // Make the request
        AF.request(urlString, method: .get, headers: headers).responseDecodable(of: AddUserResponse.self) { response in
            // Debugging: Print the raw response data (this helps to debug unexpected responses)
            if let data = response.data {
                print("Raw API Response:")
                print(String(data: data, encoding: .utf8) ?? "Unable to print data")
            }

            switch response.result {
            case .success(let addUserResponse):
                // If response is successful, return user data
                completion(.success(addUserResponse.data!))
            case .failure(let error):
                // Handle API failure and check for specific error
                if let data = response.data {
                    // Try decoding error response if it exists
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        print("API Error: \(errorResponse.message ?? "No error message")")
                    } catch {
                        print("Error decoding error response: \(error.localizedDescription)")
                    }
                }
                // Return failure with original error
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Send a notification to user about adding to the group
    
    func sendNotification(receiverId: String, groupId: String, completion: @escaping (Result<NotificationResponse, Error>) -> Void) {
        let urlString = "\(APIConstants.baseURL)/notifications"

        // Retrieve the token from UserDefaults
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "NoToken", code: 401, userInfo: [NSLocalizedDescriptionKey: "User token is missing"])))
            return
        }

        // Headers with Authorization Bearer token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]

        // Request body
        let parameters: [String: Any] = [
            "receiverId": receiverId,
            "groupId": groupId,
            "isInvite": true,
            "isRead": false
        ]

        // Make the POST request
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: NotificationResponse.self) { response in
                if let data = response.data {
                    print("Raw API Response:")
                    print(String(data: data, encoding: .utf8) ?? "Unable to print data")
                }

                switch response.result {
                case .success(let notificationResponse):
                    completion(.success(notificationResponse))
                case .failure(let error):
                    // Handle API failure and log error
                    if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorNotificationResponse.self, from: data)
                            print("API Error: \(errorResponse.message ?? "Unknown error")")
                        } catch {
                            print("Error decoding error response: \(error.localizedDescription)")
                        }
                    }
                    completion(.failure(error))
                }
            }
    }
    
    //MARK: - Get Notification
    
    func getNotification(completion: @escaping (Result<[GetNotificationModel], Error>) -> Void ) {
        let url = "\(APIConstants.baseURL)/notifications"
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "NoToken", code: 401, userInfo: [NSLocalizedDescriptionKey: "User token is missing"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [GetNotificationModel].self) { response in
            switch response.result {
            case .success(let getNotificationResponse):
                completion(.success(getNotificationResponse))
                print("Raw API Response: \(getNotificationResponse)")
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Create Hatim Group -
    
    func createHatimGroup(groupRequest: HatimGroupCreationRequest, completion: @escaping (Result<HatimCreateGroupResponse, Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "ApiManager", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated"])))
            return
        }
        
        let url = "\(APIConstants.baseURL)/groups"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: groupRequest, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: HatimCreateGroupResponse.self) { response in
            switch response.result {
            case .success(let groupResponse):
                completion(.success(groupResponse))
            case .failure(let error):
                // Handle response errors separately for better debugging
                if let data = response.data {
                    print("Raw Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
                }
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Get Hatim Group
    func fetchHatimGroups(completion: @escaping (Result<[HatimGroupData], Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "No token found", code: 401, userInfo: nil)))
            return
        }
        
        let url = "http://35.188.2.212:7474/api/v1/groups/public/mine?groupType=QURAN"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: [HatimGroupData].self) { response in
            switch response.result {
            case .success(let groups):
                completion(.success(groups))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

//MARK: - Patching and Deleting functions

extension ApiManager {
    
    //MARK: - Delete Group and Zikr
    
    // Method to delete a group
    func deleteGroup(withId groupId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/groups/\(groupId)"
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .delete, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Method to delete a zikr
    func deleteZikr(withId zikrId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/zikr/\(zikrId)"
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .delete, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    //MARK: - Patching and Deleting Notification
    
    //patching
    
    func patchNotification(at index: Int, completion: @escaping (Result<Void, Error>) -> Void) {

        guard let savedNotificationIds = UserDefaults.standard.array(forKey: "savedNotificationIds") as? [String],
              index < savedNotificationIds.count else {
            print("Invalid index or no IDs found in UserDefaults")
            completion(.failure(NSError(domain: "InvalidID", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid notification ID"])))
            return
        }
        
        let notificationId = savedNotificationIds[index]
        let url = "\(APIConstants.baseURL)/notifications/\(notificationId)"
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Missing token")
            completion(.failure(NSError(domain: "NoToken", code: 401, userInfo: [NSLocalizedDescriptionKey: "User token is missing"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = ["isRead": true]
        
        print("PATCH URL: \(url)")
        print("PATCH Parameters: \(parameters)")
        
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
            print("PATCH Response: \(response)")
            if let error = response.error {
                print("PATCH Error: \(error)")
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    
    //deleting
    
    func deleteNotification(at index: Int, completion: @escaping (Result<Void, Error>) -> Void) {

        guard let savedNotificationIds = UserDefaults.standard.array(forKey: "savedNotificationIds") as? [String],
              index < savedNotificationIds.count else {
            print("Invalid index or no IDs found in UserDefaults")
            completion(.failure(NSError(domain: "InvalidID", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid notification ID"])))
            return
        }
        
        let notificationId = savedNotificationIds[index]
        let url = "\(APIConstants.baseURL)/notifications/\(notificationId)"
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Missing token")
            completion(.failure(NSError(domain: "NoToken", code: 401, userInfo: [NSLocalizedDescriptionKey: "User token is missing"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        print("DELETE URL: \(url)")
        
        AF.request(url, method: .delete, headers: headers).response { response in
            print("DELETE Response: \(response)")
            if let error = response.error {
                print("DELETE Error: \(error)")
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

}
