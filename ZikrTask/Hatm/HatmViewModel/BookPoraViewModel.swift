//
//  BookPoraViewModel.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 01/11/24.
//

import Foundation
import Alamofire

class BookPoraViewModel {
    
    func bookPora(idGroup: String, poraId: String, isBooked: Bool, isDone: Bool, completion: @escaping (Result<String, Error>) -> Void) {
        let request = BookedPoraRequest(idGroup: idGroup, poraId: poraId, isBooked: isBooked, isDone: isDone)
        ApiManager.shared.bookPora(request: request, completion: completion)
    }
}
