//
//  NetworkManager.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

/*
 Acts as a mediator between a repository and HttpClient to fetch data from HttpClient,
 decode it to the required model and return result to the repository.
 */
final class NetworkManager {
    
    // MARK: Properties
    
    private let httpClient: HttpClient
    private let dataParser: DataParsing
    
    // MARK: Init
    
    init(
        httpClient: HttpClient = URLSessionHttpClient(),
        dataParser: DataParsing = JSONDataParser()
    ) {
        self.httpClient = httpClient
        self.dataParser = dataParser
    }
    
    // MARK: Public methods
    
    func execute<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data = try await httpClient.execute(endpoint)
        let decodedResponse: T = try dataParser.decode(data)
        return decodedResponse
    }
}
