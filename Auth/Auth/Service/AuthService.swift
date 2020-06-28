//
//  AuthService.swift
//  Auth
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Core

public typealias AuthSignInCompletion = (_ result: Result<Authentificatable>) -> Void
public typealias AuthSignUpCompletion = (_ result: Result<Authentificatable>) -> Void
public typealias AuthSearchCompletion = (_ result: Result<Authentificatable?>) -> Void
public typealias AuthLogoutCompletion = (_ result: Result<Bool>) -> Void
public typealias AuthResetPasswordCompletion = (_ result: Result<Bool>) -> Void

public protocol AuthService {
    
    var isAuthorized: Bool { get }
    
    var currentUser: Authentificatable? { get }
    
    func searchUser(
        byEmail email: String,
        completion: @escaping AuthSearchCompletion
    )

    func searchUser(
        byPhone email: String,
        completion: @escaping AuthSearchCompletion
    )
    
    func signInGuest(completion: @escaping AuthSignInCompletion)
    
    func signIn(
        userId: String,
        password: String,
        remember: Bool,
        completion: @escaping AuthSignInCompletion
    )
    
    func signUp(
        email: String,
        password: String,
        name: String,
        completion: @escaping AuthSignInCompletion
    )

    func signUp(
        phone: String,
        password: String,
        name: String,
        completion: @escaping AuthSignInCompletion
    )
    
    func resetPasssword(
        phone: String,
        completion: @escaping AuthResetPasswordCompletion
    )

    func resetPasssword(
        email: String,
        completion: @escaping AuthResetPasswordCompletion
    )
    
    func logout(completion: @escaping AuthLogoutCompletion)

}
