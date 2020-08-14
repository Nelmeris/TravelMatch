//
//  ProfileData.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation

public protocol ProfileData {
    var imageUrl: URL? { get }
    var name: String { get }
    var phoneNumber: String { get }
}
