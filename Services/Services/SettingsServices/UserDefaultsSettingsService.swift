//
//  UserDefaultsSettingsService.swift
//  Services
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import Profile

public class UserDefaultsSettingsService: NotifySettingsService {
    
    private let userDefaults: UserDefaults
    
    private let notifySettingsKey = "notifySettings"
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    public func get() -> Profile.NotifySettings {
        return getSettings()
    }
    
    public func setIsPushOn(_ isOn: Bool) {
        var settings = getSettings()
        settings.isPushOn = isOn
        setSettings(settings)
    }
    
    public func setIsSmsOn(_ isOn: Bool) {
        var settings = getSettings()
        settings.isSmsOn = isOn
        setSettings(settings)
    }
    
    public func setIsEmailOn(_ isOn: Bool) {
        var settings = getSettings()
        settings.isEmailOn = isOn
        setSettings(settings)
    }
    
    private func setSettings(_ settings: NotifySettings) {
        try? userDefaults.set(object: settings, forKey: notifySettingsKey)
    }
    
    private func getSettings() -> NotifySettings {
        if let settings = try? userDefaults.get(objectType: NotifySettings.self, forKey: notifySettingsKey) {
            return settings
        } else {
            let settings = NotifySettings(isPushOn: false, isSmsOn: false, isEmailOn: false)
            setSettings(settings)
            return settings
        }
    }
    
}
