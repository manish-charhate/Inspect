//
//  NetworkError.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidRequest
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
            case .invalidRequest:
                return "NetworkError: Invalid request"
                
            case .invalidResponse:
                return "NetworkError: Invalid response"
                
            case .invalidStatusCode(let statusCode):
                return "NetworkError: Invalid status code: \(statusCode)"
        }
    }
}
