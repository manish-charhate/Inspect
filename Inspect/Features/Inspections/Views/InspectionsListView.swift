//
//  InspectionsListView.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import SwiftUI

struct InspectionsListView: View {
    
    @ObservedObject var viewModel: InspectionsTabViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.inspections) { inspection in
                    let isInspectionDone = viewModel.inspectionStatuses[inspection.id] ?? false
                    
                    DisclosureGroup {
                        let categories = inspection.survey.categories
                        
                        Section(header: Text("Categories").bold()) {
                            ForEach(categories) { category in
                                Button {
                                    viewModel.selectedInspectionId = inspection.id
                                    viewModel.selectedCategory = category
                                } label: {
                                    HStack {
                                        Text("\(category.name)")
                                            .padding(.leading)
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Inspection \(inspection.id)")
                                    .font(.headline)
                                Text("Area: \(inspection.area.name)")
                                    .font(.subheadline)
                                Text("Type: \(inspection.inspectionType.name)")
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            Text("\(isInspectionDone ? "Done" : "Pending")")
                                .font(.caption)
                                .padding(.all, 4.0)
                                .foregroundStyle(.white)
                                .background(isInspectionDone ? Color.green : Color.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 2.0, style: .continuous))
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Inspections")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.startNewInspection()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .fullScreenCover(item: $viewModel.selectedCategory) { category in
                QuestionnaireView(
                    viewModel: QuestionnaireViewModel(
                        repository: viewModel.repository,
                        questions: category.questions,
                        inspectionId: viewModel.selectedInspectionId,
                        categoryId: category.id
                    )
                )
            }
        }
    }
}
