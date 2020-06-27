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
    
    private var authorized = false
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func isAuthorized() -> Bool {
        return authorized
    }
    
    func signIn(withPhone phone: String, password: String, remember: Bool, completion: @escaping AuthCompletion) {
        authorized = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(AuthResult(token: "demo_token", error: nil))
        }
    }
    
    func signIn(withEmail email: String, password: String, remember: Bool, completion: @escaping AuthCompletion) {
        authorized = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(AuthResult(token: "demo_token", error: nil))
        }
    }
    
    func logout() {
        
    }

}
