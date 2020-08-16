//
//  UserDefaultsUser.swift
//  Models
//
//  Created by Artem Kufaev on 25.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Auth
import Foundation
import Profile

public struct UserDefaultsUser: Codable, Identifiable {
    public let id: String
    public let imageUrl: URL?
    public let name: String
    public let surname: String
    public let gender: String
    public let email: String
    public let phoneNumber: String
    public let password: String
    
    public init(id: String,
                name: String,
                password: String,
                phoneNumber: String = "",
                email: String = "") {
        self.id = id
        self.name = name
        self.password = password
        surname = ""
        gender = ""
        self.email = email
        self.phoneNumber = phoneNumber
        imageUrl = nil
    }
    
    public init(id: String,
                imageUrl: URL?,
                name: String,
                surname: String,
                gender: String,
                email: String,
                phoneNumber: String,
                password: String) {
        self.id = id
        self.imageUrl = imageUrl
        self.name = name
        self.surname = surname
        self.gender = gender
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
    }
}

extension UserDefaultsUser: Authentificatable {}
extension UserDefaultsUser: ProfileData {}
extension UserDefaultsUser: PersonalInfo {}
