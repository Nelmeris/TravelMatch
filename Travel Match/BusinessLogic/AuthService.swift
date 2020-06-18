//
//  AuthService.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation

typealias AuthCompletion = (AuthResult) -> Void

protocol AuthService {
    
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
