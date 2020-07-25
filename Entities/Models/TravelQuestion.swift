//
//  TravelQuestion.swift
//  Models
//
//  Created by Artem Kufaev on 25.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

public struct TravelQuestion {
    public let title: String
    public let description: String
    public let answers: [TravelAnswer]
    
    public init(title: String,
                description: String,
                answers: [TravelAnswer]) {
        self.title = title
        self.description = description
        self.answers = answers
    }
}
