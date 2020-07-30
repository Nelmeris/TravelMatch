//
//  AuthLogout.swift
//  Profile
//
//  Created by Artem Kufaev on 30.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

public protocol AuthLogout {
    typealias AuthLogoutCompletion = (Result<Bool, Error>) -> ()
    func logout(completion: @escaping AuthLogoutCompletion)
    func subscribeOnLogout(observer: Any, selector: Selector)
}
