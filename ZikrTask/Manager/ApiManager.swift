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
    
    private init() {}
    
    //MARK: - Create User
    
    func registerUser(userRequest: UserRegisterRequest, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void) {
        let url = "https://dzikr.uz/register"
        
        AF.request(url, method: .post, parameters: userRequest, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: UserRegisterResponse.self) {response in
                switch response.result {
                case .success(let userResponse):
                    completion(.success(userResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
//    func createUser(userBodyPart: UserBodyPart, completion: @escaping (Result<UserModel, Error>) -> Void) {
//        let url = APIConstants.addUserURL()
//
//        AF.request(url, method: .post, parameters: userBodyPart, encoder: JSONParameterEncoder.default)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    print("Raw response: \(value)")  // Print raw response for debugging
//
//                    // Ensure that the response matches the expected structure
//                    do {
//                        let data = try JSONSerialization.data(withJSONObject: value, options: [])
//                        let userModel = try JSONDecoder().decode(UserModel.self, from: data)
//                        completion(.success(userModel))
//                    } catch {
//                        print("Decoding error: \(error.localizedDescription)")
//                        completion(.failure(error))
//                    }
//                case .failure(let error):
//                    print("Request Error: \(error.localizedDescription)")
//                    completion(.failure(error))
//                }
//            }
//    }

    
    // MARK: - Login User
    
//    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
//        let url = APIConstants.loginURL(mail: email, password: password)
//        
//        AF.request(url).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
//                    guard let user = loginResponse.user.first else {
//                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user found"])))
//                        return
//                    }
//                    completion(.success(user))
//                } catch {
//                    completion(.failure(error))
//                }
//                
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
    //MARK: - Add group
//    func addGroup(groupRequest: GroupRequest, completion: @escaping (Result<GroupResponse, Error>) -> Void) {
//        let url = APIConstants.addGroupURL()
//        
//        AF.request(url, method: .post, parameters: groupRequest, encoder: JSONParameterEncoder.default)
//            .responseData { response in
//                switch response.result {
//                case .success(let data):
//                    // Print the raw data for debugging
//                    if let jsonString = String(data: data, encoding: .utf8) {
//                        print("Response JSON: \(jsonString)")
//                    }
//                    
//                    // Check if the response status code indicates success
//                    guard let statusCode = response.response?.statusCode, (200...299).contains(statusCode) else {
//                        let errorMessage = "HTTP Status Code: \(response.response?.statusCode ?? -1)"
//                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
//                        return
//                    }
//                    
//                    // Decode the response if status code is 200-299
//                    do {
//                        let decodedResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
//                        completion(.success(decodedResponse))
//                    } catch {
//                        completion(.failure(error))
//                        print("Decoding Error: \(error)")
//                    }
//                    
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//    
    //MARK: - Get Group
//    func fetchGroups(completion: @escaping (Result<[Group], Error>) -> Void) {
//        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
//            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"])))
//            return
//        }
//        
//        let url = APIConstants.getGroupsURL(ownerId: userId)
//        
//        AF.request(url).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
//                    completion(.success(groupsResponse.data))
//                } catch {
//                    completion(.failure(error))
//                }
//                
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
    //MARK: - Subcribe to the Group
//    func subscribeToGroup(userId: Int, groupId: Int, completion: @escaping (Result<String, Error>) -> Void) {
//        let url = APIConstants.subscribeToGroupURL()
//        
//        // Create the request body
//        let parameters: [String: Any] = [
//            "userId": userId,
//            "groupId": groupId
//        ]
//        
//        // Send the POST request
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
//            switch response.result {
//            case .success(let data):
//                if let json = data as? [String: Any], let status = json["status"] as? String, status == "200" {
//                    let message = json["message"] as? String ?? "Subscription successful"
//                    completion(.success(message))
//                } else {
//                    let errorMessage = (data as? [String: Any])?["message"] as? String ?? "Unknown error"
//                    completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
