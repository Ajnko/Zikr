//
//  GetBookedPora.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 02/11/24.
//

import Foundation
import Alamofire

class GetBookedPoraViewModel {
    
    var bookedPoras: [GetBookedPora] = []
    var didUpdateData: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchBookedPoras(groupId: String) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Token not found in UserDefaults")
            return
        }
        
        let urlString = "https://dzikr.uz/api/v1/booked-poralar?groupId=\(groupId)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(urlString, method: .get, headers: headers).validate().responseDecodable(of: [GetBookedPora].self) { [weak self] response in
            switch response.result {
            case .success(let bookedPoras):
                self?.bookedPoras = bookedPoras
                self?.didUpdateData?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func deleteBookedPora(byId id: String, completion: @escaping (Bool) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Token not found in UserDefaults")
            completion(false)
            return
        }
        
        let urlString = "https://dzikr.uz/api/v1/booked-poralar/\(id)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(urlString, method: .delete, headers: headers).validate().response { response in
            switch response.result {
            case .success:
                print("Successfully deleted booked pora with ID: \(id)")
                completion(true)
            case .failure(let error):
                print("Error deleting booked pora: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func deleteAllBookedPoras(completion: @escaping (Bool) -> Void) {
        guard !bookedPoras.isEmpty else {
            completion(true)
            return
        }
        
        let group = DispatchGroup()
        var isSuccessful = true
        
        for bookedPora in bookedPoras {
            group.enter()
            deleteBookedPora(byId: bookedPora.id) { success in
                if !success { isSuccessful = false }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(isSuccessful)
        }
    }
}

