//
//  GetFinishedPoraViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 04/12/24.
//

import Alamofire

class GetFinishedPoraViewModel {
    
    func fetchJuzCount(forPoraID poraID: String, completion: @escaping (Int) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Authorization token not found.")
            completion(0)
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        let url = "https://dzikr.uz/api/v1/finished-poralar-count/\(poraID)"
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: FinishedPoraResponse.self) { response in
            switch response.result {
            case .success(let data):
                print("Fetched juzCount for poraID \(poraID): \(data.juzCount)")
                completion(data.juzCount)
            case .failure(let error):
                print("Failed to fetch data for poraID \(poraID): \(error)")
                completion(0)
            }
        }
    }
}
