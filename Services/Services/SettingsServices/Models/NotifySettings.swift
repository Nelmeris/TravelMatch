//
//  NotifySettings.swift
//  Services
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Profile

public struct NotifySettings: Codable, Profile.NotifySettings {
    public var isPushOn: Bool
    public var isSmsOn: Bool
    public var isEmailOn: Bool
}
