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

        ApiManager.shared.createUser(userBodyPart: userBodyPart) { result in
            switch result {
            case .success(let userModel):
                self.saveUserToUserDefaults(userModel)
                completion(.success(userModel))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func saveUserToUserDefaults(_ userModel: UserModel) {
        let userResult = userModel.data

        // Save basic user details
        UserDefaults.standard.set(userResult.userId, forKey: "userId")
        UserDefaults.standard.set(phone, forKey: "phone")
        UserDefaults.standard.set(mail, forKey: "email")
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(surname, forKey: "surname")

        // Ensure UserDefaults changes are synced
        UserDefaults.standard.synchronize()
    }
}
