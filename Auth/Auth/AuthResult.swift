//
//  AuthResult.swift
//  Auth
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

public struct AuthResult {
    
    let token: String
    let error: String?
    
    public init(token: String, error: String?) {
        self.token = token
        self.error = error
    }
    
}
