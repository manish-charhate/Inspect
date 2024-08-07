//
//  InspectionsTabViewModel.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

final class InspectionsTabViewModel: ObservableObject {
    
    @Published private(set) var inspections = [Inspection]()
    @Published private(set) var isLoading = false
    @Published var selectedCategory: Category?
    @Published var selectedInspectionId = 0
    @Published private(set) var inspectionStatuses = [Int: Bool]()
    
    let repository: InspectionsRepository
    
    init(repository: InspectionsRepository) {
        self.repository = repository
    }
    
    @MainActor func loadInspections() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        let inspections = repository.fetchInspections().map { $0.inspection }
        
        inspections.forEach { inspection in
            var isInspectionDone = true
            
            for category in inspection.survey.categories {
                for question in category.questions {
                    if question.selectedAnswerChoiceID == nil {
                        isInspectionDone = false
                        break
                    }
                }
            }
            
            inspectionStatuses[inspection.id] = isInspectionDone
        }
        
        self.inspections = inspections
    }
    
    @MainActor func startNewInspection() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            let inspectionData = try await repository.startNewInspection()
            inspections.append(inspectionData.inspection)
            
            await loadInspections()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
