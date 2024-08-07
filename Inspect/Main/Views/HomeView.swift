//
//  HomeView.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation
import SwiftUI

enum TabType {
    case inspections
    case profile
}

struct HomeView: View {
    
    @State private var selectedTab = TabType.inspections
    
    let inspectionsTabView: InspectionsTabView
    let profileTabView: ProfileTabView
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            inspectionsTabView
                .tabItem {
                    Label(
                        title: { Text("Inspections") },
                        icon: { Image(systemName: "pencil.and.list.clipboard") }
                    )
                }
                .tag(TabType.inspections)
            
            profileTabView
                .tabItem {
                    Label(
                        title: { Text("Profile") },
                        icon: { Image(systemName: "person.fill") }
                    )
                }
                .tag(TabType.profile)
        }
    }
}
