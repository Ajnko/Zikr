//
//  HatmGroupDetailsViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 14/10/24.
//

import Foundation
import Alamofire

class HatmGroupDetailsViewModel {
    
    func fetchHatmGroupDetails(idGroup: String, completion: @escaping (Result<HatmGroupDetialsData, Error>) -> Void) {
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(.failure(NSError(domain: "ApiManager", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not authorized"])))
            return
        }
        
        let url = "https://dzikr.uz/api/v1/groups/\(idGroup)/details"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                if let jsonString = String(data: data, encoding: .utf8) {
                    
                }
                do {
                    let groupDetailsResponse = try JSONDecoder().decode(HatmGroupDetailResponse.self, from: data)
                    completion(.success(groupDetailsResponse.data))
                    
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Failed to fetch group details: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
