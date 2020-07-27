//
//  FakeOffer.swift
//  Offers
//
//  Created by Artem Kufaev on 27.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

public protocol FakeOffer {
    var id: Int { get }
    var name: String { get }
    var image: String { get }
    var price: Int { get }
    var description: String { get }
    var inFavorite: Bool { get set }
}
