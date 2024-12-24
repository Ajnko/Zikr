//
//  BookedPoralarViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 20/12/24.
//

import Alamofire

class PatchBookedPoralarViewModel {
    
    func patchBookedPoralar(
        id: String,
        requestBody: PatchBookedPoralarRequest,
        completion: @escaping (Result<PatchBookedPoralarResponse, Error>) -> Void
    ) {
        let url = "https://dzikr.uz/api/v1/booked-poralar/\(id)"
        
        // Headers (if needed)
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
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
