//
//  TravelAnswer.swift
//  Models
//
//  Created by Artem Kufaev on 25.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Questions

public struct TravelAnswer {
    public let id: String
    public let title: String
    public let imageURL: URL
    
    public init(id: String,
                title: String,
                imageURL: URL) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
}

extension TravelAnswer: Answer {}
