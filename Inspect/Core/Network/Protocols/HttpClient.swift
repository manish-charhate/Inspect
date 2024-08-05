//
//  HttpClient.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

protocol HttpClient {
    
    func execute(_ endpoint: Endpoint) async throws -> Data
}
