//
//  ProfileModel.swift
//  Services
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Profile

struct ProfileModel: ProfileData {
    let imageUrl: URL?
    let name: String
    let phoneNumber: String
}
