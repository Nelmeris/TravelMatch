//
//  AuthService.swift
//  Auth
//
//  Created by Maxim Timokhin on 25.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Core
import Models

public typealias AuthLoginCompletion = (_ result: Result<Authentificatable, Error>) -> Void
public typealias AuthSignUpCompletion = (_ result: Result<Authentificatable, Error>) -> Void
public typealias AuthSearchCompletion = (_ result: Result<Authentificatable?, Error>) -> Void
public typealias AuthResetPasswordCompletion = (_ result: Result<Bool, Error>) -> Void

public protocol AuthSearch {
    func searchUser(
        byEmail email: String,
        completion: @escaping AuthSearchCompletion
    )

    func searchUser(
        byPhone email: String,
        completion: @escaping AuthSearchCompletion
    )
}

public protocol AuthLogin {
    func login(
        userId: String,
        password: String,
        remember: Bool,
        completion: @escaping AuthLoginCompletion
    )
    func loginGuest(completion: @escaping AuthLoginCompletion)
}

public protocol AuthSignUp {
    func signUp(
        email: String,
        password: String,
        name: String,
        completion: @escaping AuthLoginCompletion
    )

    func signUp(
        phone: String,
        password: String,
        name: String,
        completion: @escaping AuthLoginCompletion
    )
}

public protocol AuthReset {
    func resetPassword(
        phone: String,
        completion: @escaping AuthResetPasswordCompletion
    )

    func resetPassword(
        email: String,
        completion: @escaping AuthResetPasswordCompletion
    )
}
