//
//  JSONDataParser.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

final class JSONDataParser: DataParsing {
    
    // MARK: Properties
    
    private let jsonDecoder: JSONDecoder
    
    // MARK: Init
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    // MARK: DataParsing Impl
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
