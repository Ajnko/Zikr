//
//  UserViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 08/07/24.
//

import Foundation
import Alamofire

class CreateUserViewModel {
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
    }
}
