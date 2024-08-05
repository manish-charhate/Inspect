//
//  AuthenticationView.swift
//  Inspect
//
//  Created by Manish Charhate on 04/08/24.
//

import Foundation
import SwiftUI

struct AuthenticationView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 32.0) {
                Text("Welcome to Inspect")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Sign Up or Log In to continue")
                    .font(.body)
                
                Group {
                    TextField("Email", text: $viewModel.email)
                    
                    SecureField("Password", text: $viewModel.password)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .overlay {
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(.indigo, lineWidth: 1.0)
                }
                
                HStack(spacing: 32.0) {
                    loginButton
                    
                    signUpButton
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .padding()
        .alert("Oh No!", isPresented: $viewModel.showAlert) {
            Button("Okay") {}
        } message: {
            Text(viewModel.errorMessage)
        }
    }
    
    var loginButton: some View {
        createButton(with: "Log In") {
            Task {
                await viewModel.signIn()
            }
        }
    }
    
    var signUpButton: some View {
        createButton(with: "Sign Up") {
            Task {
                await viewModel.signUp()
            }
        }
    }
    
    private func createButton(with text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
                .bold()
                .padding()
                .frame(width: 100)
                .background(.indigo)
                .foregroundStyle(.white)
                .cornerRadius(8)
        }
    }
}
