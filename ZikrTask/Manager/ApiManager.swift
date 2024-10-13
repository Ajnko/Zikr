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
