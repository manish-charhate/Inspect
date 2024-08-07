//
//  InspectionsAPIRepository.swift
//  Inspect
//
//  Created by Manish Charhate on 06/08/24.
//

import Foundation

final class InspectionsAPIRepository: InspectionsRepository {
    
    // MARK: Properties
    
    private let networkManager: NetworkManager
    private let dataStore: InspectionsDataStore
    
    // MARK: Init
    
    init(networkManager: NetworkManager, dataStore: InspectionsDataStore) {
        self.networkManager = networkManager
        self.dataStore = dataStore
    }
    
    // MARK: InspectionsRepository Impl
    
    func startNewInspection() async throws -> InspectionData {
        let data: InspectionData = try await networkManager.execute(StartInspectionEndpoint())
        dataStore.saveInspection(data)
        return data
    }
    
    func fetchInspections() -> [InspectionData] {
        return dataStore.fetchInspections()
    }
    
    func saveAnswer(
        withChoiceId choiceId: Int,
        forQuestionId questionId: Int,
        ofCategoryId categoryId: Int,
        andInspectionId inspectionId: Int
    ) -> Bool {
        var inspections = dataStore.fetchInspections()
        
        guard let targetInspectionIndex = inspections.firstIndex(where: { $0.inspection.id == inspectionId }) else {
            return false
        }
        
        var targetInspection = inspections[targetInspectionIndex].inspection
        
        if let categoryIndex = targetInspection.survey.categories.firstIndex(where: { $0.id == categoryId }),
           let questionIndex = targetInspection.survey.categories[categoryIndex].questions.firstIndex(where: { $0.id == questionId }) {
            
            // Create a mutable copy of the question and update the selectedAnswerChoiceID
            var updatedQuestion = targetInspection.survey.categories[categoryIndex].questions[questionIndex]
            updatedQuestion.selectedAnswerChoiceID = choiceId
            
            // Create a mutable copy of the category and update the question
            var updatedCategory = targetInspection.survey.categories[categoryIndex]
            updatedCategory.questions[questionIndex] = updatedQuestion
            
            // Update the categories array with the updated category
            var updatedCategories = targetInspection.survey.categories
            updatedCategories[categoryIndex] = updatedCategory
            
            // Create a mutable copy of the survey and update the categories
            var updatedSurvey = targetInspection.survey
            updatedSurvey.categories = updatedCategories
            
            // Update the inspection with the updated survey
            targetInspection.survey = updatedSurvey
        } else {
            return false
        }
        
        inspections[targetInspectionIndex] = InspectionData(inspection: targetInspection)
        dataStore.saveInspections(inspections)
        return true
    }
    
    func submitInspection(withId inspectionId: Int) async throws -> Bool {
        let inspections = dataStore.fetchInspections()
        
        guard let inspection = inspections.first(where: { $0.inspection.id == inspectionId }) else { return false }
        
        let success: Bool = try await networkManager.execute(SubmitInspectionEndpoint(inspection: inspection))
        return success
    }
}
