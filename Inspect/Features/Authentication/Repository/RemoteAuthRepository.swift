//
//  RemoteAuthRepository.swift
//  Inspect
//
//  Created by Manish Charhate on 04/08/24.
//

import Foundation

struct RemoteAuthRepository: AuthenticationRepository {
    
    // MARK: Properties
    
    let networkManager: NetworkManager
    
    // MARK: Init
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: AuthenticationRepository Impl
    
    func login(withEmail email: String, andPassword password: String) async throws -> Bool {
        return try await networkManager.execute(SignInEndpoint(email: email, password: password))
    }
    
    func createAcount(withEmail email: String, andPassword password: String) async throws -> Bool {
        return try await networkManager.execute(SignUpEndpoint(email: email, password: password))
    }
}
