//
//  AuthService.swift
//  Auth
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

public typealias AuthCompletion = (AuthResult) -> Void

public protocol AuthService {
    
    func isAuthorized() -> Bool

    func signIn(
        withPhone phone: String,
        password: String,
        remember: Bool,
        completion: @escaping AuthCompletion
    )
    
    func signIn(
        withEmail email: String,
        password: String,
        remember: Bool,
        completion: @escaping AuthCompletion
    )
    
    func logout()

}
