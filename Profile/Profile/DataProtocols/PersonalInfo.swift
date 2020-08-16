//
//  PersonalInfo.swift
//  Profile
//
//  Created by Artem Kufaev on 16.08.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

public protocol PersonalInfo {
    var name: String { get }
    var surname: String { get }
    var gender: String { get }
    var email: String { get }
    var phoneNumber: String { get }
    var password: String { get }
}
