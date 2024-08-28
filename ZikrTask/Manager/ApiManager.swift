//
//  ApiManager.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 24/08/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPError: LocalizedError {
    case invalidResponse
    case serverError(statusCode: Int, data: Data?)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server."
        case .serverError(let statusCode, _):
            return "Server returned an error with status code: \(statusCode)"
        }
    }
    
    var data: Data? {
        switch self {
        case .serverError(_, let data):
            return data
        case .invalidResponse:
            return nil
        }
    }
}

class ApiManager {
    static let shared = ApiManager()
    
    private init() {}
    
    func performRequest<T: Codable>(url: URL, method: HTTPMethod, requestBody: Data?, parameters: [String: Any]? = nil, responseType: T.Type, headers: [String: String]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        guard let requestURL = urlComponents?.url else {
            // Handle invalid URL
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        
//        if let token = User_Defalts.shared.getAuthToken() {
//            // Add token to request headers
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
        
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.setValue("keep-alive", forHTTPHeaderField: "Connection")
          request.setValue("2.2.404", forHTTPHeaderField: "User-Agent-Version") // Corrected line
          
        if let params = parameters {
            var queryItems = [URLQueryItem]()
            for (key, value) in params {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                queryItems.append(queryItem)
            }
            urlComponents?.queryItems = queryItems
        }
        
        if let additionalHeaders = headers {
            for (key, value) in additionalHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpBody = requestBody
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(HTTPError.invalidResponse))
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode) {
                if let responseData = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(responseType, from: responseData)
                        completion(.success(decodedResponse))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(HTTPError.invalidResponse))
                }
            } else {
                completion(.failure(HTTPError.serverError(statusCode: httpResponse.statusCode, data: data)))
            }
        }
        
        dataTask.resume()
    }
}
