//
//  QuestionnaireViewModel.swift
//  Inspect
//
//  Created by Manish Charhate on 06/08/24.
//

import Foundation

final class QuestionnaireViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var questions: [Question]
    @Published var currentQuestionIndex: Int = 0
    
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    var isFirstQuestion: Bool {
        currentQuestionIndex == 0
    }
    
    var isLastQuestion: Bool {
        currentQuestionIndex == questions.count - 1
    }
    
    let inspectionId: Int
    let categoryId: Int
    
    private let repository: InspectionsRepository
    
    // MARK: Init
    
    init(repository: InspectionsRepository, questions: [Question], inspectionId: Int, categoryId: Int) {
        self.repository = repository
        self.questions = questions
        self.inspectionId = inspectionId
        self.categoryId = categoryId
    }
    
    // MARK: Public methods
    
    func goToNextQuestion() {
        if !saveResponse() {
            return
        }
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        }
    }
    
    func goToPreviousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }
    
    func submit() -> Bool {
        return saveResponse()
    }
    
    func selectOption(_ option: AnswerChoice) {
        questions[currentQuestionIndex].selectedAnswerChoiceID = option.id
    }
    
    // MARK: Private helpers
    
    private func saveResponse() -> Bool {
        return repository.saveAnswer(
            withChoiceId: currentQuestion.selectedAnswerChoiceID ?? 0,
            forQuestionId: currentQuestion.id,
            ofCategoryId: categoryId,
            andInspectionId: inspectionId
        )
    }
}
