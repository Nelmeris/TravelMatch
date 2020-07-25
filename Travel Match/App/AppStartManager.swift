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
        coordinator = AppCoordinator(
            onBoardingService: UserDefaultsOnBoardingService(
                userDefaults: UserDefaults.standard
            ),
            authService: UserDefaultsAuthService(
                userDefaults: UserDefaults.standard
            ),
            questionsService: TravelQuestionService(
                userDefaults: UserDefaults.standard
            )
        )
        
        coordinator?.start()
    }
    
}
