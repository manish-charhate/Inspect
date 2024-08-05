//
//  MainView.swift
//  Inspect
//
//  Created by Manish Charhate on 04/08/24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    let authViewFactory: () -> AuthenticationView
    
    let homeViewFactory: () -> HomeView
    
    var body: some View {
        if viewModel.isUserAuthenticated {
            homeViewFactory()
        } else {
            authViewFactory()
        }
    }
}
