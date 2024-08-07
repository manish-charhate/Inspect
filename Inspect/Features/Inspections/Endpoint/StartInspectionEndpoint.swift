//
//  StartInspectionEndpoint.swift
//  Inspect
//
//  Created by Manish Charhate on 06/08/24.
//

import Foundation

struct StartInspectionEndpoint: Endpoint {
    
    var path: String {
        return "/api/inspections/start"
    }
    
    var methodType: HttpMethodType {
        return .GET
    }
}
