//
//  InspectApp.swift
//  Inspect
//
//  Created by Manish Charhate on 04/08/24.
//

import SwiftUI

@main
struct InspectApp: App {
    
    let appContainer = AppDependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            appContainer.makeMainView()
        }
    }
}
