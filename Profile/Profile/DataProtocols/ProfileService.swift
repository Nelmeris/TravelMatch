//
//  ProfileService.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

public protocol ProfileService {
    typealias ProfileLogoutCompletion = (Result<Bool, Error>) -> ()
    typealias ProfileSaveDataCompletion = (Result<Bool, Error>) -> ()
    func logout(completion: @escaping ProfileLogoutCompletion)
    func getProfileData() -> ProfileData & PersonalInfo
    func saveProfileData(name: String,
                         surname: String,
                         gender: String,
                         email: String,
                         phoneNumber: String,
                         password: String,
                         completion: @escaping ProfileLogoutCompletion) 
}
