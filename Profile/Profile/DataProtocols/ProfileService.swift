//
//  ProfileService.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

public protocol ProfileService {
    func getProfileData() -> ProfileData
}
