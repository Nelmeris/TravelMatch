//
//  AuthService.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 14.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import Foundation
import Core
import Auth
import Profile

public protocol AuthService: AuthLogin & AuthReset & AuthSearch & AuthSignUp & AuthLogout {
    var isAuthorized: Bool { get }
    var currentUser: UserDefaultsUser? { get set }
}

public final class UserDefaultsAuthService: AuthService {

    private let userDefaults: UserDefaults
    private let notificationCenter: NotificationCenter
    
    private let logoutNotifyName = NSNotification.Name(rawValue: "logoutNotify")
    
    public init(userDefaults: UserDefaults,
                notificationCenter: NotificationCenter) {
        self.userDefaults = userDefaults
        self.notificationCenter = notificationCenter
    }
    
    // MARK: - AuthService
    
    public var isAuthorized: Bool {
        return currentUser != nil
    }
    
    public var currentUser: UserDefaultsUser? {
        get {
            try? userDefaults.get(
                objectType: UserDefaultsUser.self,
                forKey: "currentUser"
            )
        }
        set {
            try? userDefaults.set(
                object: newValue,
                forKey: "currentUser"
            )
        }
    }
    
    public func searchUser(
        byEmail email: String,
        completion: @escaping AuthSearchCompletion
    ) {
        do {
            let user = try userDefaults.get(
                objectType: UserDefaultsUser.self,
                forKey: email
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(user))
            }
        } catch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.failure(error))
            }
        }
    }
    
    public func searchUser(
        byPhone email: String,
        completion: @escaping AuthSearchCompletion
    ) {
        
        do {
            let user = try userDefaults.get(
                objectType: UserDefaultsUser.self,
                forKey: email
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.success(user))
            }
        } catch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(.failure(error))
            }
        }
    }
    
    public func loginGuest(
        completion: @escaping AuthLoginCompletion
    ) {
        let user = UserDefaultsUser(
            id: "guest",
            name: "Guest",
            password: ""
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentUser = user
            completion(.success(user))
        }
    }
    
    public func login(
        userId: String,
        password: String,
        remember: Bool,
        completion: @escaping AuthLoginCompletion
    ) {
        do {
            if let user = try userDefaults.get(
                objectType: UserDefaultsUser.self,
                forKey: userId),
                user.password == password {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.currentUser = user
                    completion(.success(user))
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    completion(.failure(CoreError(message: "Пользователь не найден")))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    public func signUp(
        email: String,
        password: String,
        name: String,
        completion: @escaping AuthLoginCompletion
    ) {
        let user = UserDefaultsUser(
            id: email,
            name: name,
            password: password,
            email: email
        )
        try? userDefaults.set(object: user, forKey: user.id)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentUser = user
            completion(.success(user))
        }
    }
    
    public func signUp(
        phone: String,
        password: String,
        name: String,
        completion: @escaping AuthLoginCompletion
    ) {
        let user = UserDefaultsUser(
            id: phone,
            name: name,
            password: password,
            phoneNumber: phone
        )
        try? userDefaults.set(object: user, forKey: user.id)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentUser = user
            completion(.success(user))
        }
    }
    
    public func resetPassword(phone: String, completion: @escaping AuthResetPasswordCompletion) {
        do {
            if (try userDefaults.get(
                objectType: UserDefaultsUser.self,
                forKey: phone)) != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    completion(.success(true))
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    completion(.failure(CoreError(message: "Пользователь не найден")))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    public func resetPassword(email: String, completion: @escaping AuthResetPasswordCompletion) {
        do {
            if (try userDefaults.get(
                objectType: UserDefaultsUser.self,
                forKey: email)) != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    completion(.success(true))
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    completion(.failure(CoreError(message: "Пользователь не найден")))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    public func logout(completion: @escaping AuthLogoutCompletion) {
        currentUser = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(true))
            self.notificationCenter.post(name: self.logoutNotifyName, object: nil)
        }
    }
    
    public func subscribeOnLogout(observer: Any, selector: Selector) {
        notificationCenter.addObserver(observer,
                                       selector: selector,
                                       name: logoutNotifyName,
                                       object: nil)
    }

}
