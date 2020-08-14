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
    
    private let authService: AuthService
    
    public init(authService: AuthService) {
        self.authService = authService
    }
    
    public func getProfileData() -> ProfileData {
        return ProfileModel(imageUrl: Bundle.main.url(forResource: "profileImage", withExtension: "png"),
                            name: "Константин Коронов",
                            phoneNumber: "+7 922 328 93 34")
    }
    
    public func logout(completion: @escaping ProfileLogoutCompletion) {
        authService.logout(completion: completion)
    }
    
}
