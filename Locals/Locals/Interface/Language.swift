//
//  Language.swift
//  Locals
//
//  Created by Maxim Timokhin on 10.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation


/// Языки, которыми владеет гид
public protocol Language {
    
    /// Название языыка
    var title: String { get }
        
    /// Уровень владения языком, 0..100
    var level: Int { get }
}
