//
//  AuthenticationRepository.swift
//  Inspect
//
//  Created by Manish Charhate on 04/08/24.
//

import Foundation

protocol AuthenticationRepository {
    
    func login(withEmail email: String, andPassword password: String) async throws -> Bool
    
    func createAcount(withEmail email: String, andPassword password: String) async throws -> Bool
}
