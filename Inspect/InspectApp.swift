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
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            appContainer.makeMainView()
        }
    }
}
