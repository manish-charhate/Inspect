//
//  SignUpResponder.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

protocol SignUpResponder {
    
    @MainActor func userDidSignUp(success: Bool)
}
