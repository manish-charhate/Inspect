//
//  QuestionnaireView.swift
//  Inspect
//
//  Created by Manish Charhate on 06/08/24.
//

import SwiftUI

struct QuestionnaireView: View {
    
    @ObservedObject var viewModel: QuestionnaireViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .padding()
                        .foregroundStyle(.indigo)
                }
            }
            
            Spacer()
            
            Text(viewModel.currentQuestion.name)
                .font(.title)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(viewModel.currentQuestion.answerChoices) { choice in
                    HStack {
                        let isAnswerSelected = viewModel.currentQuestion.selectedAnswerChoiceID == choice.id
                        
                        Image(systemName: isAnswerSelected ? "largecircle.fill.circle" : "circle")
                            .font(.title2)
                            .foregroundStyle(.indigo)
                            .onTapGesture {
                                viewModel.selectOption(choice)
                            }
                        
                        Text(choice.name)
                            .padding(.leading, 5)
                            .onTapGesture {
                                viewModel.selectOption(choice)
                            }
                    }
                    .padding(.vertical, 5)
                }
            }
            
            Spacer()
            
            HStack {
                if !viewModel.isFirstQuestion {
                    Button(action: {
                        viewModel.goToPreviousQuestion()
                    }) {
                        Text("Previous")
                    }
                }
                
                Spacer()
                
                if viewModel.isLastQuestion {
                    Button {
                        Task {
                            if await viewModel.submit() {
                                dismiss()
                            }
                        }
                    } label : {
                        Text("Submit")
                    }
                } else {
                    Button(action: {
                        viewModel.goToNextQuestion()
                    }) {
                        Text("Next")
                    }
                }
            }
            .padding()
        }
        .padding()
    }
}
