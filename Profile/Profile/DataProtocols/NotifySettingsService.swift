//
//  NotifySettingsService.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

public protocol NotifySettingsService {
    func get() -> NotifySettings
    func setIsPushOn(_ isOn: Bool)
    func setIsSmsOn(_ isOn: Bool)
    func setIsEmailOn(_ isOn: Bool)
}
