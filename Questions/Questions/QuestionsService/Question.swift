//
//  Question.swift
//  Questions
//
//  Created by Maxim Timokhin on 26.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

public protocol Question {
    var title: String { get }
    var description: String { get }
    var answers: [Answer] { get }
}
