//
//  Review.swift
//  Models
//
//  Created by Artem Kufaev on 25.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

public struct Review {
    public let id: Int
    public let offerID: Int
    public let ownerName: String
    public let ownerImage: UIImage
    public let date: Date
    public let description: String
    
    public init(id: Int, offerID: Int, ownerName: String, ownerImage: UIImage, date: Date, description: String) {
        self.id = id
        self.offerID = offerID
        self.ownerName = ownerName
        self.ownerImage = ownerImage
        self.date = date
        self.description = description
    }
}
