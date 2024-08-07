//
//  InspectionsEmptyStateView.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import SwiftUI

struct InspectionsEmptyStateView: View {
    
    @ObservedObject var viewModel: InspectionsTabViewModel
    
    @State private var showQuestionnaire = false
    
    var body: some View {
        VStack {
            Image(systemName: "clipboard")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .foregroundColor(.gray.opacity(0.7))
            
            Text("No inspections done yet")
                .font(.title2)
                .foregroundStyle(.gray.opacity(0.7))
            
            Button {
                Task {
                    await viewModel.startNewInspection()
                    showQuestionnaire = true
                }
            } label: {
                Text("Start New Inspection")
                    .bold()
                    .padding()
                    .background(.indigo)
                    .foregroundStyle(.white)
                    .cornerRadius(8)
            }
        }
        .fullScreenCover(isPresented: $showQuestionnaire) {
            Text("hello")
        }
    }
}
