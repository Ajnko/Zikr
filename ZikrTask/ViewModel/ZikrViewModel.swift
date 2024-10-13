//
//  ZikrViewModel.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 12/10/24.
//


import Foundation

//class ZikrViewModel {
//    func createZikr(name: String, desc: String, body: String, goal: Int, completion: @escaping (String?) -> Void) {
//        let zikrRequest = ZikrRequest(name: name, desc: desc, body: body, goal: goal)
//        
//        ApiManager.shared.createZikr(zikrRequest: zikrRequest) { result in
//            switch result {
//            case .success(let zikrResponse):
//                // Successfully created Zikr, you can save the response or handle it as needed
//                UserDefaults.standard.set(zikrResponse.id, forKey: "zikrId")
//                completion("Zikr created successfully: \(zikrResponse.id)")
//                print("Zikr created successfully with ID: \(zikrResponse.id)")
//            case .failure(let error):
//                completion("Failed to create Zikr: \(error.localizedDescription)")
//            }
//        }
//    }
//}
