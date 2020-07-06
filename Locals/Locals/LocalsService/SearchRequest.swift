//
//  SearchRequest.swift
//  Locals
//
//  Created by Maxim Timokhin on 06.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation


public struct SearchRequest {    
    let priceFrom: Double?
    let priceTo: Double?
    let language: [String]?
    let activity: [String]?
    let gender: [String]?
    let interests: [String]?
}
