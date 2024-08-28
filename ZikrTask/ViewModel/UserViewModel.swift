//
//  UserViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 08/07/24.
//

import Foundation
import Alamofire

class UserViewModel {
    var phone: String = ""
    var mail: String = ""
    var name: String = ""
    var surname: String = ""
    var password: String = ""
    
    func validateInput() -> Bool {
        return !phone.isEmpty && !mail.isEmpty && !name.isEmpty && !surname.isEmpty && !password.isEmpty
    }
    
    func createUser(completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard validateInput() else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Please complete all fields."])))
            return
        }
        
        guard let phoneInt = Int(phone) else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid phone number."])))
            return
        }
        
        let userBodyPart = UserBodyPart(
            phone: phoneInt,
            mail: mail,
            name: name,
            surname: surname,
            image_url: "http://example.com/images/johndoe.jpg",
            password: password
        )
        
        let url = "https://dzikr.uz/zikrs/add-user"
        
        AF.request(url, method: .post, parameters: userBodyPart, encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let errorMessage = json["error"] as? String {
                    print("Server Error: \(errorMessage)")
                    completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                } else {
                    // Try decoding the response if it's successful and in the expected format
                    do {
                        let data = try JSONSerialization.data(withJSONObject: value, options: [])
                        let userModel = try JSONDecoder().decode(UserModel.self, from: data)
                        completion(.success(userModel))
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Request Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        //MARK: - Internal server error
//        AF.request(url, method: .post, parameters: userBodyPart, encoder: JSONParameterEncoder.default).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                print("Response JSON: \(value)") // Log the raw JSON response
//                // Optionally, you can try to manually decode this JSON into your model if it looks correct
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)") // Log any errors
//            }
//        }
    }
}
//MARK: - old view model
//class UserViewModel {
//    var user: UserBodyPart?
//    
//    func createUser(completion: @escaping (Result<UserModel, Error>) -> Void) {
//        guard let user = user else { return }
//        
//
//
//        let parameters: [String: Any] = [
//            "phone": user.phone,
//            "name": user.name,
//            "surname": user.surname,
//            "password": user.password
//        ]
//        
//        let url = "https://dzikr.uz/zikrs/add-user"
//        
//        AF.upload(multipartFormData: { multiFormData in
//            for (key, value) in parameters {
//                if let data = "\(value)".data(using: .utf8) {
//                    multiFormData.append(data, withName: key)
//                }
//            }
//        }, to: url).response { response in
//            // Check the HTTP status code
//            if let statusCode = response.response?.statusCode {
//                if statusCode == 200 || statusCode == 201 {
//                    // Try decoding the response only if status code indicates success
//                    switch response.result {
//                    case .success(let data):
//                        if let data = data {
//                            do {
//                                let userModel = try JSONDecoder().decode(UserModel.self, from: data)
//                                print("User created successfully: \(userModel)")
//                                completion(.success(userModel))
//                            } catch let decodingError {
//                                print("Decoding error: \(decodingError)")
//                                completion(.failure(decodingError))
//                            }
//                        }
//                    case .failure(let error):
//                        print("Request failed with error: \(error.localizedDescription)")
//                        completion(.failure(error))
//                    }
//                } else {
//                    // Handle the 422 or any other error codes explicitly
//                    print("Error: Received HTTP status code \(statusCode)")
//                    completion(.failure(NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP error \(statusCode)"])))
//                }
//            } else {
//                print("Error: No status code received.")
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No response from server."])))
//            }
//        }
//    }
//}

//class UserViewModel {
//    var user: UserBodyPart?
//    
//    func createUser(completion: @escaping (Result<String, Error>) -> Void) {
//        guard let user = user else { return }
//        
//        guard let phoneNumber = Int(user.phoneNumber) else {
//            print("Error: Invalid phone number format.")
//            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid phone number format."])))
//            return
//        }
//        
//        var parameters: [String: Any] = [
//            "phone"      : phoneNumber,
//            "mail"       : user.mail,
//            "name"       : user.name,
//            "surname"    : user.surname,
//            "image_url"  : user.imageUrl,
//            "password"   : user.password
//        ]
//        
//        print("Parameters: \(parameters)")
//
//        
//        let url = "https://dzikr.uz/zikrs/add-user"
//        
//        AF.upload(multipartFormData: { multiFormData in
//            for (key, value) in parameters {
//                if let data = "\(value)".data(using: .utf8) {
//                    multiFormData.append(data, withName: key)
//                }
//            }
//        }, to: url).response { response in
//            switch response.result {
//            case .success(let data):
//                if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                    print("Response: \(responseString)")
//                    completion(.success(responseString))
//                }
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//                completion(.failure(error))
//            }
//            
//        }
//    }
//}
//
//
