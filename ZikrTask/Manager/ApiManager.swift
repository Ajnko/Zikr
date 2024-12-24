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
        
        // Making POST request with Alamofire
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
    
    //    func createZikr(zikrRequest: ZikrRequest, completion: @escaping (Result<ZikrResponse, Error>) -> Void) {
    //        guard let token = UserDefaults.standard.string(forKey: "token"),
    //              let groupId = UserDefaults.standard.string(forKey: "groupId") else {
    //            completion(.failure(NSError(domain: "Token or Group ID not found", code: 401, userInfo: nil)))
    //            return
    //        }
    //
    //        let url = "\(APIConstants.baseURL)/zikr"
    //
    //        var parameters: [String: Any] = [
    //            "name": zikrRequest.name,
    //            "desc": zikrRequest.desc,
    //            "body": zikrRequest.body,
    //            "goal": zikrRequest.goal,
    //            "sound_url": "https://example.com/sound.mp3", // Use your sound URL as needed
    //            "groupId": groupId
    //        ]
    //
    //        // Making POST request with Alamofire
    //        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(token)"]).responseDecodable(of: ZikrResponse.self) { response in
    //            switch response.result {
    //            case .success(let zikrResponse):
    //                completion(.success(zikrResponse))
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    
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
    
    //MARK: - Get Group
    
    func getGroups(completion: @escaping (Result<[Group], Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/groups/public/mine?groupType=ZIKR"
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [Group].self) { response in
            switch response.result {
            case .success(let groups):
                completion(.success(groups))
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
        
        let url = "https://dzikr.uz/api/v1/groups"
        
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
    func getPublicHatmGroups(completion: @escaping (Result<[HatmGroupData], Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "No token found", code: 401, userInfo: nil)))
            return
        }
        
        let url = "https://dzikr.uz/api/v1/groups/public/mine?groupType=QURAN"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        print(token)
        AF.request(url, headers: headers).responseDecodable(of: [HatmGroupData].self) { response in
            switch response.result {
            case .success(let groups):
                completion(.success(groups))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPrivateHatmGroups(completion: @escaping (Result<[HatmGroupData], Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "No token found", code: 401, userInfo: nil)))
            return
        }
        
        let url = "https://dzikr.uz/api/v1/groups/private/mine?groupType=QURAN"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        print(token)
        AF.request(url, headers: headers).responseDecodable(of: [HatmGroupData].self) { response in
            switch response.result {
            case .success(let groups):
                completion(.success(groups))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Get poralar
    func fetchPoralar(completion: @escaping (Result<[PoralarModel], Error>) -> Void) {
        let url = "https://dzikr.uz/api/v1/poralar"
        
        AF.request(url, method: .get).responseDecodable(of: [PoralarModel].self) { response in
            switch response.result {
            case .success(let groups):
                completion(.success(groups))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Get User Profile
    
    func fetchUserProfile(completion: @escaping (Result<HatmGroupUserModel, Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Token not found in UserDefaults.")
            return
        }
        
        let url = "https://dzikr.uz/api/v1/users/me"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: UserProfileResponse.self) { response in
            switch response.result {
            case .success(let userProfileResponse):
                if userProfileResponse.status {
                    completion(.success(userProfileResponse.data))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user data"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Book Pora
    
    func bookPora(request: BookedPoraRequest, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://dzikr.uz/api/v1/booked-poralar") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "Token not found", code: 0, userInfo: nil)))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            if let id = responseJSON?["id"] as? String {
                                print("Extracted ID: \(id)")
                                completion(.success(id))
                            } else {
                                completion(.failure(NSError(domain: "ID not found in response", code: 0, userInfo: nil)))
                            }
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(NSError(domain: "No data in response", code: 0, userInfo: nil)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    //MARK: - Notification
    
    //MARK: - Get Notification
    
    func getNotification(completion: @escaping (Result<[GetHatmNotificationModel], Error>) -> Void ) {
        let url = "\(APIConstants.baseURL)/notifications"
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "NoToken", code: 401, userInfo: [NSLocalizedDescriptionKey: "User token is missing"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [GetHatmNotificationModel].self) { response in
            switch response.result {
            case .success(let getNotificationResponse):
                completion(.success(getNotificationResponse))
                print("Raw API Response: \(getNotificationResponse)")
            case .failure(let error):
                completion(.failure(error))
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
    
    //MARK: - Send a notification to user about adding to the group
    
    func sendNotification(receiverId: String, groupId: String, completion: @escaping (Result<HatmNotificationResponse, Error>) -> Void) {
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
            .responseDecodable(of: HatmNotificationResponse.self) { response in
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
    
    //MARK: - Find User By Phone number
    
    func fetchUser(phone: String, completion: @escaping (Result<AddHatmUser, Error>) -> Void) {
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
        AF.request(urlString, method: .get, headers: headers).responseDecodable(of: AddHatmUserResponse.self) { response in
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
    
}
