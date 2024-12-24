//
//  ZikrCountViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 23/10/24.
//

import Foundation

class ZikrCountViewModel {
    var groupId: String
    var zikrId: String
    var count: Int = 0
    
    init(groupId: String, zikrId: String) {
        self.groupId = groupId
        self.zikrId = zikrId
    }
    
    func postZikrCount(completion: @escaping(Result<ZikrCountResponse, Error>) -> Void) {
        let request = ZikrCountRequest(groupId: groupId, zikrId: zikrId, count: count)
        
        ApiManager.shared.postZikrCount(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


//class ZikrCountViewModel {
//    var groupId: String
//    var zikrId: String
//    var count: Int = 0
//    
//    init(groupId: String, zikrId: String) {
//        self.groupId = groupId
//        self.zikrId = zikrId
//    }
//    
//    func postZikrCount(completion: @escaping(Result<ZikrCountResponse, Error>) -> Void) {
//        
//        let request = ZikrCountRequest(groupId: groupId, zikrId: zikrId, count: count)
//        
//        ApiManager.shared.postZikrCount(request: request) { result in
//            switch result {
//            case .success(let response):
//                completion(.success(response))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
