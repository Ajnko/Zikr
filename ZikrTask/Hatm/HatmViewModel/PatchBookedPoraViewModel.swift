//
//  Untitled.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 20/12/24.
//

import Alamofire

class PatchBookedPoraViewModel {
    
    func patchBookedPoralar(
        id: String,
        requestBody: PatchBookedPoralarRequest,
        completion: @escaping (Result<PatchBookedPoralarResponse, Error>) -> Void
    ) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Authorization token not found.")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        let url = "https://dzikr.uz/api/v1/booked-poralar/\(id)"
        
        // Perform the PATCH request
        AF.request(url, method: .patch, parameters: requestBody, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .responseDecodable(of: PatchBookedPoralarResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
