//
//  Interest.swift
//  Locals
//
//  Created by Maxim Timokhin on 10.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation


/// Интересы гида
public protocol Interest {
    
    /// URL-адрес иконки
    var iconURL: URL { get }
    
    /// Название интереса
    var title: String { get }
}
