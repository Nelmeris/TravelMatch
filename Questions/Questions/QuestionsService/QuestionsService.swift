//
//  QuestionsService.swift
//  Questions
//
//  Created by Maxim Timokhin on 29.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Core

public typealias GetQuestionsCompletion = (_ result: Result<Question, Error>) -> Void
public typealias SaveAnswersCompletion = (_ result: Result<Bool, Error>) -> Void

public protocol QuestionsService {

    var shouldShowQuestion: Bool { get }
    
    /// Получить данные для опроса
    /// - Parameter completion: Result<Question>
    func getQuestion(
        completion: @escaping GetQuestionsCompletion
    )
        
    /// Сохранить выбранные варианты ответов
    /// - Parameters:
    ///   - answers: массив с выбранными ответами
    ///   - completion: Result<Bool>
    func saveAnswers(
        _ answers: [Answer],
        completion: @escaping SaveAnswersCompletion
    )
    
}
