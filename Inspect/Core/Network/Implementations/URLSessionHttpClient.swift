//
//  URLSessionHttpClient.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

final class URLSessionHttpClient {
    
    // MARK: Private properties
    
    private let urlSession: URLSession
    
    // MARK: Init
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension URLSessionHttpClient: HttpClient {
    
    func execute(_ endpoint: Endpoint) async throws -> Data {
        let urlRequest = try endpoint.createURLRequest()
        
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        // Handle the case where the response body is empty
        if data.isEmpty {
            let isEmptyResponse = true
            let encodedData = try JSONEncoder().encode(isEmptyResponse)
            return encodedData
        }
        
        return data
    }
}
