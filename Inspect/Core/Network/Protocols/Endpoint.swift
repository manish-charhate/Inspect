//
//  Endpoint.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

protocol Endpoint {
    
    var path: String { get }
    
    var methodType: HttpMethodType { get }
    
    var body: [String: Any] { get }
}

// Extension with default implementations
extension Endpoint {
    
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return "127.0.0.1"
    }
    
    var body: [String: Any] {
        return [:]
    }
}

// Extension which creates URLRequest object using current endpoint
extension Endpoint {
    
    func createURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = scheme
        urlComponents.path = path
        urlComponents.port = 5001
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidRequest
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = methodType.rawValue
        
        if !body.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
