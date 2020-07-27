//
//  LocalEntity.swift
//  Services
//
//  Created by Artem Kufaev on 27.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Locals

struct LocalEntity: Local {
    let imageURL: URL
    let imageLargeURL: URL
    let name: String
    let aboutText: String
    let interests: [Interest]
    let languages: [Language]
    let activities: [Activity]
    let price: Double
    let priceDescriptor: String
}
