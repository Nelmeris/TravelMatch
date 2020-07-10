//
//  Local.swift
//  Locals
//
//  Created by Maxim Timokhin on 05.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

public protocol Local {
    var imageURL: URL { get }
    var name: String { get }
    var interests: [Interest] { get }
    var languages: [Language] { get }
    var activities: [Activity] { get }
    var price: Double { get }
    var priceDescriptor: String { get }
}
