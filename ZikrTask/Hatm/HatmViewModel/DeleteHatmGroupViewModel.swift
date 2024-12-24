//
//  DeleteHatmGroupViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 02/11/24.
//

import Alamofire

class DeleteHatmGroupViewModel {
    var groups: [HatmGroupData] = []
    
    func deleteGroup(with groupID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Token not found in UserDefaults")
            return
        }
        
        let url = "https://dzikr.uz/api/v1/groups/\(groupID)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request(url, method: .delete, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                if let statusCode = response.response?.statusCode, statusCode == 204 {
                    completion(.success(()))
                } else {
                    // Handle other status codes or errors here
                    let error = NSError(domain: "", code: response.response?.statusCode ?? 500, userInfo: [NSLocalizedDescriptionKey: "Failed to delete group."])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
