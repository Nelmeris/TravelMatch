//
//  Answer.swift
//  Questions
//
//  Created by Maxim Timokhin on 26.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

public protocol Answer {
    var title: String { get }
    var imageURL: URL { get }
}
