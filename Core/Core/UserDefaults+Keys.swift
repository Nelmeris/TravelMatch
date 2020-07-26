//
//  UserDefaultsService.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    enum DefaultKeys: String {
        case onBoardingShown = "onboarding.shown"
        case questionsShown = "questions.shown"
    }
    
    func object(forKey key: DefaultKeys) -> Any? {
        return object(forKey: key.rawValue)
    }
    
    func string(forKey key: DefaultKeys) -> String? {
        return string(forKey: key.rawValue)
    }
    
    func bool(forKey key: DefaultKeys) -> Bool {
        return bool(forKey: key.rawValue)
    }
    
    func set(_ value: String, forKey key: DefaultKeys) {
        set(value, forKey: key.rawValue)
    }
    
    func set(_ value: Bool, forKey key: DefaultKeys) {
        set(value, forKey: key.rawValue)
    }
    
    func set(_ value: Any?, forKey key: DefaultKeys) {
        set(value, forKey: key.rawValue)
    }
}
