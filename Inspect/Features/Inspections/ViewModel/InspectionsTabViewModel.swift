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
    
    let repository: InspectionsRepository
    
    init(repository: InspectionsRepository) {
        self.repository = repository
    }
    
    @MainActor func loadInspections() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        inspections = repository.fetchInspections().map { $0.inspection }
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
