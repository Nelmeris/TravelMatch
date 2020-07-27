//
//  UserDefaultsUser.swift
//  Models
//
//  Created by Artem Kufaev on 25.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Auth

public struct UserDefaultsUser: Codable, Identifiable {
    public let id: String
    public let name: String
    public let password: String
    
    public init(id: String,
                name: String,
                password: String) {
        self.id = id
        self.name = name
        self.password = password
    }
}

extension UserDefaultsUser: Authentificatable {}
