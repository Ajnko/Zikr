//
//  GroupViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 18/07/24.
//

import Foundation
import Alamofire

class GroupViewModel {
    var group: Group?
    
    func createGroup(completion: @escaping(Result<String, Error>) -> Void) {
        guard let group = group else { return }
        
        let parameters: [String: Any] = [
            "ownerId"   : group.ownerId,
            "name"      : group.name,
            "purpose"   : group.purpose,
            "comment"   : group.comment ?? "",
            "isPublic"  : group.isPublic
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let data = "\(value)".data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: "https://zikrgroup.000webhostapp.com/create_group.php")
        .response { response in
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
