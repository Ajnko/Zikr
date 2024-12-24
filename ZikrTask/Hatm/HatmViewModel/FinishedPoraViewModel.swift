//
//  FinishedPoraViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 22/11/24.
//

import Alamofire

class FinishedPoraViewModel {
    
    var onSuccess: ((FinishedPoraResponse) -> Void)?
    var onFailure: ((Error) -> Void)?
    var onTargetLayersCompleted: (() -> Void)?
    
    private var groupJuzCounts: [String: Int] {
        get {
            if let data = UserDefaults.standard.data(forKey: "groupJuzCounts"),
               let counts = try? JSONDecoder().decode([String: Int].self, from: data) {
                return counts
            }
            return [:]
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "groupJuzCounts")
            }
        }
    }
    
    private func findJuzCount(for groupId: String) -> Int {
        return groupJuzCounts[groupId] ?? 1
    }
    
    private func updateJuzCount(for groupId: String, juzCount: Int) {
        groupJuzCounts[groupId] = juzCount
    }
    
    private var groupMapping: [[String: String]] {
        get {
            if let data = UserDefaults.standard.data(forKey: "groupMapping"),
               let mapping = try? JSONDecoder().decode(
                [[String: String]].self,
                from: data
               ) {
                return mapping
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "groupMapping")
            }
        }
    }
    
    private func findPoraId(for groupId: String) -> String? {
        return groupMapping.first { $0.keys.contains(groupId) }?[groupId]
    }
    
    private func addPoraId(for groupId: String, poraId: String) {
        if let index = groupMapping.firstIndex(where: { $0.keys.contains(groupId) }) {
            groupMapping[index][groupId] = poraId
        } else {
            groupMapping.append([groupId: poraId])
        }
    }
    
    func sendFinishedPoraRequest(idGroup: String) {
        let currentJuzCount = findJuzCount(for: idGroup)
        let newJuzCount = currentJuzCount + 1
        
        if let poraId = findPoraId(for: idGroup) {
            patchFinishedPoraRequest(id: poraId, juzCount: newJuzCount - 1)
        } else {
            postFinishedPoraRequest(idGroup: idGroup, juzCount: 1)
        }
        
        updateJuzCount(for: idGroup, juzCount: newJuzCount)
        
        fetchGroupData(groupId: idGroup) { hatmCount in
            if let hatmCount = hatmCount {
                if newJuzCount - 1 == hatmCount {
                    DispatchQueue.main.async {
                        print("You have done all the targeted layers for this group.")
                        self.onTargetLayersCompleted?()
                    }
                } else {
                    print("Mismatch between newJuzCount and hatmCount.")
                }
            } else {
                print("Failed to fetch hatmCount. hatmCount is nil.")
            }
        }
    }
    
    func postFinishedPoraRequest(idGroup: String, juzCount: Int) {
        let url = "https://dzikr.uz/api/v1/finished-poralar-count"
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Authorization token not found.")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        let requestBody = FinishedPoraRequest(idGroup: idGroup, juzCount: juzCount)
        
        AF.request(
            url,
            method: .post,
            parameters: requestBody,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: FinishedPoraResponse.self) { response in
            switch response.result {
            case .success(let responseData):
                self.addPoraId(for: idGroup, poraId: responseData.id)
                print("POST successful. New finishedPoraId:", responseData.id)
                self.onSuccess?(responseData)
                
            case .failure(let error):
                self.onFailure?(error)
            }
        }
    }
    
    private func patchFinishedPoraRequest(id: String, juzCount: Int) {
        let url = "https://dzikr.uz/api/v1/finished-poralar-count/\(id)"
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Authorization token not found.")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        let requestBody: [String: Int] = ["juzCount": juzCount]
        
        AF.request(
            url,
            method: .patch,
            parameters: requestBody,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: FinishedPoraResponse.self) { response in
            switch response.result {
            case .success(let responseData):
                print("PATCH successful. Updated juzCount:", responseData.juzCount)
                self.onSuccess?(responseData)
                
            case .failure(let error):
                self.onFailure?(error)
            }
        }
    }
    
    func fetchGroupData(groupId: String, completion: @escaping (Int?) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Authorization token not found.")
            completion(nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        let url = "https://dzikr.uz/api/v1/groups/\(groupId)"
        print("Fetching group data for URL: \(url)")
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: HatmGroupJuzCountDetails.self) { response in
                switch response.result {
                case .success(let groupData):
                    print("Successfully fetched group data: \(groupData)")
                    completion(groupData.hatmSoni)
                case .failure(let error):
                    print("Error fetching group data: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
    
}

