//
//  AuthDependencyContainer.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

final class AuthDependencyContainer {
    
    // MARK: Properties
    
    let authViewModel: AuthenticationViewModel
    
    // MARK: Init
    
    init(appContainer: AppDependencyContainer) {
        let authRepository = RemoteAuthRepository(networkManager: appContainer.networkManager)
        
        authViewModel = AuthenticationViewModel(
            repository: authRepository,
            signInResponder: appContainer.mainViewModel,
            signUpResponder: appContainer.mainViewModel
        )
    }
    
    // MARK: Public methods
    
    func makeAuthenticationView() -> AuthenticationView {
        return AuthenticationView(viewModel: authViewModel)
    }
}
