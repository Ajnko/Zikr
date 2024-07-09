//
//  UserViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 08/07/24.
//

import Foundation
import Alamofire

class UserViewModel {
    var user: User?
    
    func createUser(completion: @escaping (Result<String, Error>) -> Void) {
        guard let user = user else { return }
        
        let url = "https://zikrgroup.000webhostapp.com/create_user.php"
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(user.name.data(using: .utf8)!, withName: "name")
            if let surname = user.surname {
                multipartFormData.append(surname.data(using: .utf8)!, withName: "surname")
            }
            multipartFormData.append(user.mail.data(using: .utf8)!, withName: "mail")
            multipartFormData.append(user.password.data(using: .utf8)!, withName: "password")
            multipartFormData.append(user.phoneNumber.data(using: .utf8)!, withName: "phone_number")
        }, to: url)
        .response { response in
            print("Request: \(response.request?.httpBody?.description ?? "No body")")
            print("Response: \(response)")
            switch response.result {
            case .success(let data):
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                    completion(.success(responseString))
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}


//class UserViewModel{
//    var user: User?
//    
//    func createUser(completion: @escaping(Result<String, Error>) -> Void) {
//        guard let user = user else { return }
//        
//        let parameters: [String: Any] = [
//            "name": user.name,
//            "surname": user.surname ?? "",
//            "password": user.password,
//            "mail": user.mail,
//            "phoneNumber": user.phoneNumber
//        ]
//        
//        print("Parameters being sent: \(parameters)")
//        
//        AF.request("https://zikrgroup.000webhostapp.com/create_user.php", method: .post, parameters: parameters, encoding: JSONEncoding.default).response {respone in
//            switch respone.result {
//            case .success(let data):
//                if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                    print("Response: \(responseString)")
//                    completion(.success(responseString))
//                }
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//                completion(.failure(error))
//            }
//        }
//        
//    }
//}
