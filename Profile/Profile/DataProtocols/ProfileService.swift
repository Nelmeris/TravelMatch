//
//  ProfileService.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

public protocol ProfileService {
    typealias ProfileLogoutCompletion = (Result<Bool, Error>) -> ()
    func logout(completion: @escaping ProfileLogoutCompletion)
    func getProfileData() -> ProfileData
}
