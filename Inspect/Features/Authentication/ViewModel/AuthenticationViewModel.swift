//
//  AuthenticationViewModel.swift
//  Inspect
//
//  Created by Manish Charhate on 04/08/24.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var email = ""
    @Published var password = ""
    @Published var showAlert = false
    @Published private(set) var errorMessage = ""
    @Published private(set) var isLoading = false
    
    private let repository: AuthenticationRepository
    private let signInResponder: SignInResponder
    private let signUpResponder: SignUpResponder
    
    // MARK: Init
    
    init(
        repository: RemoteAuthRepository,
        signInResponder: SignInResponder,
        signUpResponder: SignUpResponder
    ) {
        self.repository = repository
        self.signInResponder = signInResponder
        self.signUpResponder = signUpResponder
    }
    
    // MARK: Public methods
    
    @MainActor func signIn() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            let success = try await repository.login(withEmail: email, andPassword: password)
            signInResponder.userDidSignIn(success: success)
        } catch {
            debugPrint(error)
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
    
    @MainActor func signUp() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            let success = try await repository.login(withEmail: email, andPassword: password)
            signUpResponder.userDidSignUp(success: success)
        } catch {
            debugPrint(error)
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
}
