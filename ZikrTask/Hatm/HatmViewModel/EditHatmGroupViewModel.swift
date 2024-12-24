//
//  EditHatmGroupViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 03/11/24.
//
import Alamofire

class EditHatmGroupViewModel {
    
    func editGroup(groupID: String, request: HatmGroupEditRequest, completion: @escaping (Result<HatmGroupEditResponse, Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("Token not found in UserDefaults")
            return
        }
        let url = "https://dzikr.uz/api/v1/groups/\(groupID)"
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request(url, method: .patch, parameters: request, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .responseDecodable(of: HatmGroupEditResponse.self) { response in
                switch response.result {
                case .success(let groupResponse):
                    completion(.success(groupResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
