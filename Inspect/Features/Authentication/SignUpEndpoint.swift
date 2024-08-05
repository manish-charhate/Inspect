//
//  SignUpEndpoint.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

struct SignUpEndpoint: Endpoint {
    
    let email: String
    let password: String
    
    var path: String {
        return "/api/register"
    }
    
    var methodType: HttpMethodType {
        return .POST
    }
    
    var body: [String : Any] {
        return [
            "email": email,
            "password": password
        ]
    }
}
