//
//  SignedInResponder.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

protocol SignInResponder {
    
    @MainActor func userDidSignIn(success: Bool)
}
