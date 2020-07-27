//
//  TravelQuestionService.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 29.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Questions
import Models

public final class TravelQuestionService: QuestionsService {
    
    private let userDefaults: UserDefaults
    
    public init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }
    
    public var shouldShowQuestion: Bool {
        return !userDefaults.bool(forKey: .questionsShown)
    }
    
    private let question = TravelQuestion(
        title: "Путешествие для тебя...?",
        description: "Выбери, что подходит тебе больше всего",
        answers: [
            TravelAnswer(
                id: "1",
                title: "Прогулка по городу",
                imageURL: Bundle.main.url(forResource: "q1", withExtension: "png")!
            ),
            TravelAnswer(
                id: "2",
                title: "Отдых на пляже",
                imageURL: Bundle.main.url(forResource: "q2", withExtension: "png")!
            ),
            TravelAnswer(
                id: "3",
                title: "Новые фотографии",
                imageURL: Bundle.main.url(forResource: "q3", withExtension: "png")!
            ),
            TravelAnswer(
                id: "4",
                title: "Новые знакомства",
                imageURL: Bundle.main.url(forResource: "q4", withExtension: "png")!
            ),
            TravelAnswer(
                id: "5",
                title: "Природа",
                imageURL: Bundle.main.url(forResource: "q5", withExtension: "png")!
            ),
            TravelAnswer(
                id: "6",
                title: "Местная еда",
                imageURL: Bundle.main.url(forResource: "q6", withExtension: "png")!
            ),
            TravelAnswer(
                id: "7",
                title: "Шоппинг",
                imageURL: Bundle.main.url(forResource: "q7", withExtension: "png")!
            ),
            TravelAnswer(
                id: "8",
                title: "Экскурсии",
                imageURL: Bundle.main.url(forResource: "q8", withExtension: "png")!
            ),
            TravelAnswer(
                id: "9",
                title: "Неизведонное",
                imageURL: Bundle.main.url(forResource: "q9", withExtension: "png")!
            ),
            TravelAnswer(
                id: "10",
                title: "Исследование",
                imageURL: Bundle.main.url(forResource: "q10", withExtension: "png")!
            )
        ]
    )
    
    public func getQuestion(completion: @escaping GetQuestionsCompletion) {
        completion(.success(question))
    }
    
    public func saveAnswers(_ answers: [Answer], completion: @escaping SaveAnswersCompletion) {
        userDefaults.set(true, forKey: .questionsShown)
        completion(.success(true))
    }
    
}
