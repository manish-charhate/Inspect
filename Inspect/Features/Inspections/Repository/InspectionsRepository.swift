//
//  InspectionsRepository.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

protocol InspectionsRepository {
    
    func startNewInspection() async throws -> InspectionData
    
    func fetchInspections() -> [Inspection]
    
    func saveAnswer(
        withChoiceId choiceId: Int,
        forQuestionId questionId: Int,
        ofCategoryId categoryId: Int,
        andInspectionId inspectionId: Int
    ) -> Bool
}
