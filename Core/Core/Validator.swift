//
//  Validator.swift
//  Core
//
//  Created by Artem Kufaev on 16.08.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

public class Validator {
    
    public enum `Type` {
        case name, email, password
    }
    
    private static func predicate(for type: Type) -> NSPredicate {
        switch type {
        case .name:
            return NSPredicate(
                format: "SELF MATCHES %@",
                ".{2,}"
            )
        case .email:
            return NSPredicate(
                format: "SELF MATCHES %@",
                "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            )
        case .password:
            return NSPredicate(
                format: "SELF MATCHES %@",
                ".{6,}"
            )
        }
    }
    
    public static func isValid(value: Any, type: Type) -> Bool {
        return predicate(for: type).evaluate(with: value)
    }
    
}
