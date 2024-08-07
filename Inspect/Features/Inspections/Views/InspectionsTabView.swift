//
//  InspectionsTabView.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import SwiftUI

struct InspectionsTabView: View {
    
    @ObservedObject var viewModel: InspectionsTabViewModel
    
    var body: some View {
        ZStack {
            if viewModel.inspections.isEmpty {
                InspectionsEmptyStateView(viewModel: viewModel)
            } else {
                InspectionsListView(viewModel: viewModel)
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .task {
            await viewModel.loadInspections()
        }
    }
}
