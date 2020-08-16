//
//  ProfileService.swift
//  Services
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Profile
import Foundation

public class ProfileService: Profile.ProfileService {
    
    private var authService: AuthService
    private let userDefaults: UserDefaults
    
    public init(authService: AuthService,
                userDefaults: UserDefaults) {
        self.authService = authService
        self.userDefaults = userDefaults
    }
    
    public func getProfileData() -> ProfileData & PersonalInfo {
        guard let user = authService.currentUser else { fatalError() }
        return user
    }
    
    public func logout(completion: @escaping ProfileLogoutCompletion) {
        authService.logout(completion: completion)
    }
    
    public func saveProfileData(name: String,
                                surname: String,
                                gender: String,
                                email: String,
                                phoneNumber: String,
                                password: String,
                                completion: @escaping ProfileLogoutCompletion) {
        guard let user = authService.currentUser else { return }
        let newUser = UserDefaultsUser(id: user.id,
                                       imageUrl: user.imageUrl,
                                       name: name,
                                       surname: surname,
                                       gender: gender,
                                       email: email,
                                       phoneNumber: phoneNumber,
                                       password: password)
        authService.currentUser = newUser
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(true))
        }
    }
    
}
