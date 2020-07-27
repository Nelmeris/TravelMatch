//
//  MockFakeData.swift
//  Offers
//
//  Created by Artem Kufaev on 27.07.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation

public protocol OffersService {
    var filterCollection: [String] { get }
    func getOffers(count: Int) -> [Offer]
}
