//
//  InspectionData.swift
//  Inspect
//
//  Created by Manish Charhate on 05/08/24.
//

import Foundation

// MARK: - InspectionData
struct InspectionData: Codable {
    let inspection: Inspection
}

// MARK: - Inspection
struct Inspection: Codable, Identifiable {
    let area: Area
    let id: Int
    let inspectionType: InspectionType
    var survey: Survey
}

// MARK: - Area
struct Area: Codable {
    let id: Int
    let name: String
}

// MARK: - InspectionType
struct InspectionType: Codable {
    let access: String
    let id: Int
    let name: String
}

// MARK: - Survey
struct Survey: Codable {
    var categories: [Category]
    let id: Int
}

// MARK: - Category
struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    var questions: [Question]
}

// MARK: - Question
struct Question: Codable {
    let answerChoices: [AnswerChoice]
    let id: Int
    let name: String
    var selectedAnswerChoiceID: Int?

    enum CodingKeys: String, CodingKey {
        case answerChoices, id, name
        case selectedAnswerChoiceID = "selectedAnswerChoiceId"
    }
}

// MARK: - AnswerChoice
struct AnswerChoice: Codable, Identifiable {
    let id: Int
    let name: String
    let score: Double
}
