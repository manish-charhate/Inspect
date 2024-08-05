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
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            InspectionsTabView()
                .tabItem {
                    Label(
                        title: { Text("Inspections") },
                        icon: { Image(systemName: "pencil.and.list.clipboard") }
                    )
                }
                .tag(TabType.inspections)
            
            ProfileTabView()
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
