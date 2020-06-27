//
//  AppDelegate.swift
//  Travel Match
//
//  Created by Maxim Timokhin on 13.06.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        coordinator = AppCoordinator(
            onBoardingService: UserDefaultsOnBoardingService(
                userDefaults: UserDefaults.standard
            ),
            authService: UserDefaultsAuthService(
                userDefaults: UserDefaults.standard
            )
        )
        
        coordinator?.start()
        
        return true
    }

}
