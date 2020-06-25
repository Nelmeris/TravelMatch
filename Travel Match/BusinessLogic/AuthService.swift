//
//  AuthService.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Auth

class UserDefaultsAuthService: AuthService {
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func isAuthorized() -> Bool {
        return false
    }
    
    func signIn(withPhone phone: String, password: String, remember: Bool, completion: @escaping AuthCompletion) {
        completion(AuthResult(token: "demo_token", error: nil))
    }
    
    func signIn(withEmail email: String, password: String, remember: Bool, completion: @escaping AuthCompletion) {
        completion(AuthResult(token: "demo_token", error: nil))
    }
    
    func logout() {
        
    }

}
