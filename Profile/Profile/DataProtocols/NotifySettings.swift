//
//  NotifySettings.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

public protocol NotifySettings {
    var isPushOn: Bool { get }
    var isSmsOn: Bool { get }
    var isEmailOn: Bool { get }
}
