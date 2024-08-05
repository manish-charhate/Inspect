//
//  AppDependencyContainer.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation
import SwiftUI

final class AppDependencyContainer {
    
    // MARK: Properties
    
    let networkManager: NetworkManager
    let mainViewModel: MainViewModel
    
    // MARK: Init
    
    init() {
        let httpClient = URLSessionHttpClient()
        let dataParser = JSONDataParser()
        
        networkManager = NetworkManager(httpClient: httpClient, dataParser: dataParser)
        mainViewModel = MainViewModel()
    }
    
    // MARK: Public methods
    
    func makeMainView() -> MainView {
        
        let authViewFactory = {
            return self.makeAuthView()
        }
        
        let homeViewFactory = {
            return self.makeHomeView()
        }
        
        return MainView(
            viewModel: mainViewModel,
            authViewFactory: authViewFactory,
            homeViewFactory: homeViewFactory
        )
    }
    
    func makeAuthView() -> AuthenticationView {
        let authDependencyContainer = AuthDependencyContainer(appContainer: self)
        return authDependencyContainer.makeAuthenticationView()
    }

    func makeHomeView() -> HomeView {
        HomeView()
    }
}
