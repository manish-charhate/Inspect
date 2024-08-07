//
//  InspectionsRepository.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

protocol InspectionsRepository {
    
    func startNewInspection() async throws -> InspectionData
    
    func fetchInspections() -> [InspectionData]
    
    func saveAnswer(
        withChoiceId choiceId: Int,
        forQuestionId questionId: Int,
        ofCategoryId categoryId: Int,
        andInspectionId inspectionId: Int
    ) -> Bool
    
    func submitInspection(withId inspectionId: Int) async throws -> Bool
}
