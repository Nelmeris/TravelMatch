//
//  AppStartManager.swift
//  Travel Match
//
//  Created by Artem Kufaev on 25.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit
import Services

final class AppStartManager {
    
    var window: UIWindow
    var coordinator: AppCoordinator?
    
    init(with window: UIWindow?) {
        if let window = window {
            self.window = window
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
    }
    
    public func start() {
        window.makeKeyAndVisible()
        startCoorditator()
    }
    
    public func startCoorditator() {
        
        let authService = UserDefaultsAuthService(
            userDefaults: UserDefaults.standard,
            notificationCenter: NotificationCenter.default
        )
        
        coordinator = AppCoordinator(
            onBoardingService: UserDefaultsOnBoardingService(
                userDefaults: UserDefaults.standard
            ),
            authService: authService,
            questionsService: TravelQuestionService(
                userDefaults: UserDefaults.standard
            ),
            localsService: FakeLocalsService(),
            mockFakeDataService: OffersService.data,
            profileService: ProfileService(authService: authService),
            notifySettingsService: UserDefaultsSettingsService(
                userDefaults: UserDefaults.standard
            )
        )
        
        coordinator?.start()
    }
    
}
