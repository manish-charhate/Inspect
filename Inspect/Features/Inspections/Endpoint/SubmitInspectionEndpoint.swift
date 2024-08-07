//
//  SubmitInspectionEndpoint.swift
//  Inspect
//
//  Created by Manish Charhate on 07/08/24.
//

import Foundation

struct SubmitInspectionEndpoint: Endpoint {
    
    let inspection: InspectionData
    
    var path: String {
        "/api/inspections/submit"
    }
    
    var methodType: HttpMethodType {
        .POST
    }
    
    var body: [String : Any] {
        return convertToDictionary(inspection)
    }
    
    func convertToDictionary<T: Codable>(_ object: T) -> [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(object)
            if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any] {
                return dictionary
            }
        } catch {
            print("Failed to convert Codable object to dictionary: \(error)")
        }
        return [:]
    }
}
