//
//  MainViewModel.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    @Published private(set) var isUserAuthenticated = false
}

extension MainViewModel: SignInResponder {
    
    @MainActor func userDidSignIn(success: Bool) {
        isUserAuthenticated = success
    }
}

extension MainViewModel: SignUpResponder {
    
    @MainActor func userDidSignUp(success: Bool) {
        isUserAuthenticated = success
    }
}
