//
//  FakeOffer.swift
//  Models
//
//  Created by Artem Kufaev on 25.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Offers

public struct FakeOffer {
    public let id: Int
    public let name: String
    public let image: String
    public let price: Int
    public let description: String
    public var inFavorite: Bool
    
    public init(id: Int,
                name: String,
                image: String,
                price: Int,
                description: String,
                inFavorite: Bool) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.description = description
        self.inFavorite = inFavorite
    }
}

extension FakeOffer: Offers.Offer { }
