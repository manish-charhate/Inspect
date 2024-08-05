//
//  DataParsing.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

protocol DataParsing {
    
    func decode<T: Decodable>(_ data: Data) throws -> T
}
